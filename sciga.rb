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


$stderr.puts "Fill?(y/n)"
FILL = gets.gsub(/\s+/, "") == "y" ? true : false;

$stderr.puts "Radius?";

$radius = gets.to_f;
$center = $radius + 0.5;
$diameter = $radius * 2;
$width = $center * 2;
$circumference = 0.0;
$area = 0;
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
        $x = $xSval;
        $y = $ySval;

        set();
    else
        i = 0;
        run = 0;

        while(i < $circle.length)
            while($circle[i] == '0' && i < $circle.length)
                i += 1
            end

            while($circle[i] == '1' && i < $circle.length)
                run += 1;
                i += 1;
            end

            if((i % $width) < $center)
                while($circle[i] == '0' && i < $circle.length)
                    if(FILL)
                        $circle[i] = '1';
                    end

                    run += 1;
                    i += 1
                end

                run += 1;
                i += 1;
            end

            $area += run;

            run = 0;
        end

        $stderr.puts("PI equals #{($area / ($radius ** 2)).to_s}. Area is #{$area} vs predicted area of #{($radius ** 2) * Math::PI}");

        $stdout.print("P1\n#{$width.to_i} #{$width.to_i}\n#{$circle.join}");

        exit;
    end
end
