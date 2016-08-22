require "open3"
require 'io/console'

$ale_com = ""
$ale_com << '/home/motoki/work/DQN/Arcade-Learning-Environment-0.5.1/ale'
#$ale_com << ' -run_length_encoding false'
$ale_com << ' -game_controller fifo'
$ale_com << ' -display_screen true'
#$ale_com << ' -random_seeds 0'
#$ale_com << ' -frame_skip 4' 
$ale_com << ' gopher.bin'
FirstFlag = "1,1,0,1"
RSET = 45
FIRE = 1
NUP  = 0
R = 3
L = 4
KEYS=[FIRE,L,R]

def main
   ep , k = 0, 0
   f_ep_change = false
 
   i, o, e = *Open3.popen3($ale_com)
   o.gets

   i.print FirstFlag, "\n"
   o.gets
   a = false
   inp = false
   loop do
      k = KEYS[rand(KEYS.size)]
#      if a
#         tmp = a[0][(16 * 6 + 3) *  2, 2].hex
#         tmp -= a[0][(16 * 4 + 8) *  2, 2].hex
#         p tmp
#          if tmp >= 12 
#            k = 3
#         elsif tmp >= 3
#            k = 0
#         else
#            k = 4
#         end
#      end
#      #k = FIRE if (a[0][(16 * 6 + 5) *  2, 2] == "00" if a)
      #k = RSET if f_ep_change ; f_ep_change = false
      i.print k,",0\n"
      a = o.gets.split(":")
    
      f_ep_change = true if a[2].split(",")[0] == "1"
      ep += 1 if f_ep_change
     
      system "clear" 
      #disp a[0] 
      log  a[0],ep,k
      print $ale_com
   end
end


def disp(ss)
  n,m = 0, 0
  b = true
  t = ""
  ss.each_char do |s|
     b = !b
     t << s
     if b
        case [m,n] 
        when [6,3];          print "\x1b[33m" 
        when [3,9];          print "\x1b[35m" 
        when [6,5];          print "\x1b[36m" 
        when [4,12], [4,13]; print "\x1b[32m" 
        when [4,8];          print "\x1b[31m" 
        else                 print "\x1b[39m" 
        end  
        print t
        print " " 
        if n == 15
           print "\n" 
           n = 0
           m += 1
        else 
           n += 1
        end 
        t = ""
     end
  end
end

def log(ss,ep,k)
   print "########\n",
         "\x1b[39m","usekey :",k ,"\n",
         "\x1b[32m","score  :",ss[(16 * 4 + 12) * 2, 4] ,"\n",
         "\x1b[35m","rest   :",ss[(16 * 3 + 9) *  2, 2] ,"\n", 
         "\x1b[33m","ball-x :",ss[(16 * 6 + 3) *  2, 2] ,"\n", 
         "\x1b[36m","ball-y :",ss[(16 * 6 + 5) *  2, 2] ,"\n", 
         "\x1b[31m","bar-x  :",ss[(16 * 4 + 8) *  2, 2] ,"\n", 
       	 "\x1b[39m","episode:",ep ,"\n", 
         ""
end

main
