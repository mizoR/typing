#!/usr/bin/env ruby

require 'io/console'
require 'shellwords'

def say(msg, sync: false)
  msg = Shellwords.escape(msg)

  if sync
    `say #{msg}`
  else
    Thread.new { `say #{msg}` }
  end
end

say "パソコンをするときは、部屋を明るくして、長い時間遊ばないようにしてね。", sync: true
say "それじゃあ始めるよ！", sync: true

sleep 0.3

chars = 'A'..'Z'
count = 10
chars.to_a.sample(count).each do |char|
  system 'clear'

  puts `figlet #{char}`
  say char

  IO.console.noecho do |io|
    loop do
      ans = io.getch
      exit 1 if ans == "\u0003"
      break  if char == ans.upcase

      say "違うよ。それは「#{ans}」だよ。"
    end

    say "正解だよ。", sync: true
  end
end

say %w(やったね！ すごいね！ 楽しかった？).sample + %w(また挑戦してね。 ご飯は残さず食べようね。 遊んだらお片づけをしようね。 挨拶は大きい声でしようね。).sample
