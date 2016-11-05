# A breif description of the Snake-like CIrcle Generation Algorithm(SCiGA)
#
# SCiGA, pronounced sk-ih-gah, is a scalable algorithm used for drawing circles
# and calculating PI. It is not made for pratical use, and is therefore
# inefficient.
#
# SCiGA initializes an array and starts at the point (r, 0), where r is the
# given radius. It then finds the nearest value that is r away from the center
# of the array(r, r) and isn't set to 1.
#
# SCiGA.rb implements the SCiGA algorithm and prints the circumfrence to stderr.
# It also writes a pbm of the circle to stdout

$stderr.puts "Radius?";

$sqrt8 = Math.sqrt(8);
$radius = gets.to_f;
$diameter = $radius * 2;
$width = $diameter + 2;
$circumfrence = 0.0;
$xSval = ($x = $radius + 1);
$ySval = ($y = 0);

$circle = Array.new($width ** 2, '0');

def access(x, y)
    return $circle[y * $width + x - 1];
end

def set()
    return $circle[$y * $width + $x - 1] = '1';
end

def unset()
    return $circle[$prevaccY * $width + $prevaccX - 1] = '0';
end

def getDist(x, y)
    return ($radius - Math.sqrt(((($radius + 1) - x).abs ** 2) + (($radius - y).abs ** 2))).abs;
end

while(1 == 1)
    $dist = 0.5;

    if(getDist($x - 1, $y) < $dist && access($x - 1, $y) == '0')
        $dist = getDist($xSval = $x - 1, $ySval = $y);
    end

    if(getDist($x + 1, $y) < $dist && access($x + 1, $y) == '0')
        $dist = getDist($xSval = $x + 1, $ySval = $y);
    end

    if(getDist($x, $y - 1) < $dist && access($x, $y - 1) == '0')
        $dist = getDist($xSval = $x, $ySval = $y - 1);
    end

    if(getDist($x - 1, $y - 1) < $dist && access($x - 1, $y - 1) == '0')
        $dist = getDist($xSval = $x - 1, $ySval = $y - 1);
    end

    if(getDist($x + 1, $y - 1) < $dist && access($x + 1, $y - 1) == '0')
        $dist = getDist($xSval = $x + 1, $ySval = $y - 1);
    end

    if(getDist($x, $y + 1) < $dist && access($x, $y + 1) == '0')
        $dist = getDist($xSval = $x, $ySval = $y + 1);
    end

    if(getDist($x - 1, $y + 1) < $dist && access($x - 1, $y + 1) == '0')
        $dist = getDist($xSval = $x - 1, $ySval = $y + 1);
    end

    if(getDist($x + 1, $y + 1) < $dist && access($x + 1, $y + 1) == '0')
        $dist = getDist($xSval = $x + 1, $ySval = $y + 1);
    end

    if(access($xSval, $ySval) == '0')
        $circumfrence += Math.sqrt(($xSval - $x).abs + ($ySval - $y).abs ** 2);
        $x = $xSval;
        $y = $ySval;

        set();
    else

        $stderr.puts "The circumfrence is #{$circumfrence} pixels in length. \n PI is equal to #{$circumfrence / $diameter}";

        $stdout.puts "P1\n#{$width.to_i} #{$width.to_i}\n#{$circle.join}"

        exit;
    end
end
