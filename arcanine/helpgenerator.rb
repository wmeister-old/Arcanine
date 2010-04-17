require 'syntax/convertors/abstract'

class Arcanine::HelpGenerator < Syntax::Convertors::Abstract
  def convert(text)
    commands = {}
    cur_cmd  = nil

    @tokenizer.tokenize(text) do |tok|
      if tok.group == :comment
        if tok =~ /^=begin/
          lines = tok.split(/\r?\n/)[1..-2]
        else
          lines = [tok.sub(/^#/, '')]
        end

        for line in lines
          line.strip!

          if line =~ /^command:\s+(.*)/
            cur_cmd           = $1
            commands[cur_cmd] = {}
          elsif line =~ /^alias(?:es)?:\s+(.*)/
            commands[cur_cmd][:aliases] = $1.split /\s+/
          elsif line =~ /^description:\s+(.*)/
            commands[cur_cmd][:description] = $1
          end
        end
      end
    end
    return commands
  end
end
