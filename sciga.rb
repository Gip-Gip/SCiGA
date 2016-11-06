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
# SCiGA.rb implements the SCiGA algorithm and prints the circumference to stderr
# It also writes a pbm of the circle to stdout

$stderr.puts "Radius?";

$radius = gets.to_f;
$center = $radius + 0.5;
$diameter = $radius * 2;
$width = $center * 2;
$circumference = 0.0;
$xSval = ($x = $center);
$ySval = ($y = $center - $radius);
$sqrtCnt = $normCnt = 0;

$circle = Array.new($width ** 2, '0');

def access(x, y)
    return $circle[y.round * $width + x.round - 1];
end

def set()
    return $circle[$y.round * $width + $x.round - 1] = '1';
end

def getDist(x, y)
    return ($radius - Math.sqrt(($center - x.round).abs ** 2 + ($center - y.round).abs ** 2)).abs;
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
        # The count of diagonal and straight steps can be used to calculate the
        # circumference of the circle, as
        #
        # $circumference = $normCnt + ($sqrtCnt * Math.sqrt(2));
        if(($xSval - $x).abs > 0 && ($ySval - $y).abs > 0)
            $sqrtCnt += 1;
        else
            $normCnt += 1;
        end

        $x = $xSval;
        $y = $ySval;

        set();
    else
        $circumference = $normCnt + ($sqrtCnt * Math.sqrt(2));

        $stderr.puts("The circumference is #{$circumference} pixels in length." +
                        "\nPI is equal to #{$circumference / $diameter}" +
                        "\nThe circumference is equal to #{$normCnt} " +
                        "+ (#{$sqrtCnt} * sqrt(2))");

        $stdout.puts "P1\n#{$width.to_i} #{$width.to_i}\n#{$circle.join}"

        exit;
    end
end
