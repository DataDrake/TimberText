require_relative 'timbertext'
require 'commander'

module TimberText
	class CLI
		include Commander::Methods

		def run
			program :name, 'TimberText Parser'
			program :version, TimberText::VERSION
			program :description, 'HTML Generator for the TimberText Language'

			command :build do |c|
				c.syntax = 'timber build <in_file> [out_file]'
				c.description = 'Turns TimberText file into HTML document'
				c.action do |args, options|
					case args.length
						when 1,2
							case args.length
								when 1
									out_file = $stdout
								else
									out_file = File.new(args[1], 'w+')
							end
							if out_file
								in_file = File.open(args[0], 'r')
								if in_file
									text = in_file.read
									html = TimberText.build(text)
									out_file.puts(html)
								else
									say_error("Error: could not open input file #{args[0]}")
								end
							else
								say_error("Error: could not open output file #{args[1]}")
							end

						else
							say_error('Usage: timber build <in_file> [out_file]')
					end

				end
			end
			run!
		end

	end
end