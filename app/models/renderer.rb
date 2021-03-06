class Renderer
  attr_reader :url, :width, :height
  attr_accessor :type, :size

  def initialize(type, size, url, width, height)
    @type = type
    @size = size
    @url = url
    @width = width
    @height = height
  end
  
  def each
    context = AAlib::Context.new(self.width, self.height)

    ord, owr = IO.pipe
    pid = POSIX::Spawn.spawn(stream_cmd, :out => owr)
    owr.close

    ord.each_byte.each_with_index do |byte, index|
      context.putpixel(index % self.width, index / self.width, byte)
    end

    ord.close
    Process.waitpid(pid)

    # TODO: We could possibly store the pixel values from stream into memcached
    #       We would need to test obviously how fast that is vs just using stream

    context.render

    ird, iwr = IO.pipe
    ord, owr = IO.pipe
    pid = POSIX::Spawn.spawn(gs_cmd, :in => ird, :out => owr)
    ird.close
    owr.close

    iwr.write("/pagesize [#{self.rsize} #{self.rsize}] ")

    dims, bolds, boldfonts = "", "", ""

    density = self.size.to_f / context.scrwidth
    font_size = 1.1 * density

    iwr.write("/JNMono-Regular findfont #{font_size} scalefont setfont #{136/255.0} setgray ")

    context.scrheight.times do |y|
      context.scrwidth.times do |x|
        case context.getattr(x, y)
        when AAlib::Attr::NORMAL  
          iwr.write(char_ps(x, y, context, density))
        when AAlib::Attr::DIM
          dims << char_ps(x, y, context, density)
        when AAlib::Attr::BOLD
          bolds << char_ps(x, y, context, density)
        when AAlib::Attr::BOLDFONT
          boldfonts << char_ps(x, y, context, density)
        end
      end
    end

    iwr.write("/JNMono-Light findfont #{font_size} scalefont setfont #{204/255.0} setgray ")
    iwr.write(dims)

    iwr.write("/JNMono-Regular findfont #{font_size} scalefont setfont #{24/255.0} setgray ")
    iwr.write(bolds)

    iwr.write("/JNMono-Bold findfont #{font_size} scalefont setfont #{136/255.0} setgray ")
    iwr.write(boldfonts)

    if self.type == :png
      iwr.write("200 200 translate ")
    end

    iwr.write("showpage %%EOF")
    iwr.close

    while buf = ord.read(4096)      
      yield buf
    end

    ord.close

    # TODO: See what can be done to speed up this process, perhaps play with the read buffer size

    Process.waitpid(pid)
  end

  def png?
    self.type == :png
  end
  
  def pdf?
    self.type == :pdf
  end
  
  def rsize
    # We subtract 72dpi * 3" on png's because we only show the front
    self.png? ? self.size - 216 : self.size
  end

  private
  
  def char_ps(x, y, context, density)
    ascii = context.getpixel(x, y)
    
    # No need to render empty chars
    return "" if ascii == 32

    chr = sprintf("%03o", ascii)
    
    rx = density * x
    ry = self.size - density * (y + 1)
    
    if self.png?
      rx-=108
      ry-=108
    end

    "#{rx} #{ry} moveto (\\#{chr}) show "    
  end

  def stream_cmd
    "convert #{self.url} -contrast-stretch 10% gray:-"
  end

  def gs_cmd
    cmd = "gs -q -dBATCH -dNOPAUSE -I#{Rails.root.join('fonts')} "
    cmd << "-dDEVICEWIDTHPOINTS=#{self.rsize} "
    cmd << "-dDEVICEHEIGHTPOINTS=#{self.rsize} "
    cmd << case self.type
           when :pdf
             "-sDEVICE=pdfwrite -dSubsetFonts=true "
           when :png
             "-sDEVICE=pngalpha "
           end
    cmd << "-sOutputFile=- -"
  end
end
