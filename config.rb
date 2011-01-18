class MprwConf < OpenStruct
    def self.load filename
        open(filename){|file| new parse(file)}
    end

    def self.parse file
        hash = {}

        file.lines.each do |line|
            case line
            when /^ (\w+) \s* = \s* (.*) $/x
                key, val = $1, $2

                hash[key] = val
            when /^ \s* $/x
            when /^ \s* #/x
            else
                STDERR.puts "Config error at line #{file.lineno}"
                exit 1
            end
        end

        hash
    end
end
