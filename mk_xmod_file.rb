# -*- mode:ruby; coding:utf-8 -*-
##################################
#.Xmodmapバックアップ作成
##################################
Mod = `xmodmap -pm` 
Key = `xmodmap -pke`


print "!--------------------------------------------------\n"
print "!  This file auto-generated from mk_xmod_file.rb \n"
print "!              at #{Time.now} \n"
print "!--------------------------------------------------\n"

#モディファイアー消去(clear)
print "!---Clear Modifire---\n"
Mod.each_line.with_index do |l, i|
   next if i == 0 or l == "\n" #1行目と空行は無視
   print "clear ", l.split("\s")[0], "\n"  
end

#キー設定(Keycode)
print "\n!---Keycode Setting---\n"
print  Key

#モディファイヤー設定(add)
print "\n!---Modifire Setting---\n"
Mod.each_line.with_index do |l, i|
   next if i == 0 or l == "\n" #1行目と空行は無視
   a = l.split("\s").reject{|t|t =~ /[(]/} 
   print "add ",  a.shift, " = ", a.join(" ") , "\n" if a.size >= 2 
end

print "\n!---End---\n"
