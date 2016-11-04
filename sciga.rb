# A breif description of the Snake-like CIrcle Generation Algorithm(SCiGA)
#
# SCiGA, pronounced sk-ih-gah, is a scalable algorithm used for drawing circles
# and calculating PI. It is not made for pratical use, and is therefore
# inefficient.
#
# SCiGA initializes an array and starts at the point (r, 0), where r is the
# given radius. It then finds the nearest value that is r away from the center
# of the array(r, r) and isn't set to 1. It then sets that value to 1 and moves
# to that coornate. Once the conditions can no longer be satisfied, the circle
# is smoothed to remove any pixels that are
#
# SCiGA.rb implements the SCiGA algorithm and prints the circumfrence to stderr.
# It also writes a pbm of the circle to stdout

$stderr.puts "Radius?";

$radius = gets.to_i + 1;
$diameter = $radius * 2;
$circumfrence = 0;
$prevaccX = $x = $radius;
$prevaccY = $y = 0;

$circle = Array.new($diameter ** 2, '0');

def access(x, y)
    return $circle[y * $diameter + x - 1];
end

def set()
    return $circle[$y * $diameter + $x - 1] = '1';
end

def unset()
    return $circle[$prevaccY * $diameter + $prevaccX - 1] = '0';
end

def getLen(x, y)
    return Math.sqrt((($radius - x).abs ** 2) + (($radius - y).abs ** 2)).round;
end

while(1 == 1)
    if(getLen($x - 1, $y) == $radius - 1 && access($x - 1, $y) != '1')
        $x -= 1;
        set();
    elsif(getLen($x + 1, $y) == $radius - 1 && access($x + 1, $y) != '1')
        $x += 1;
        set();
    elsif(getLen($x, $y - 1) == $radius - 1 && access($x, $y - 1) != '1')
        $y -= 1;
        set();
    elsif(getLen($x, $y + 1) == $radius - 1 && access($x, $y + 1) != '1')
        $y += 1;
        set();
    elsif(getLen($x - 1, $y - 1) == $radius - 1 && access($x - 1, $y - 1) != '1')
        $x -= 1;
        $y -= 1;
        set();
    elsif(getLen($x + 1, $y - 1) == $radius - 1 && access($x + 1, $y - 1) != '1')
        $x += 1;
        $y -= 1;
        set();
    elsif(getLen($x - 1, $y + 1) == $radius - 1 && access($x - 1, $y + 1) != '1')
        $x -= 1;
        $y += 1;
        set();
    elsif(getLen($x + 1, $y + 1) == $radius - 1 && access($x + 1, $y + 1) != '1')
        $x += 1;
        $y += 1;
        set();
    else
        i = 0;

        $stderr.puts "Smoothing out the circle...";

        while(i < $circle.length)
            if(i > $radius && ($circle[i - 1]  == '1' || $circle[i + 1] == '1') && ($circle[i - $diameter] == '1' || $circle[i + $diameter] == '1') && $circle[i] == '1')
                $circle[i] = '0';
                $circumfrence -= 1;
            end
            i += 1;
        end

        $stderr.puts "The circumfrence is #{$circumfrence} pixels in length";

        $stdout.puts "P1\n#{$diameter} #{$diameter}\n#{$circle.join}"

        exit;
    end

    $prevaccX = $x;
    $prevaccY = $y;

    $circumfrence += 1;
end
