module Shell
  def execute( cmd, options = {} )
    defaults = {
      :quiet => false,
      :confirm_first => false,         
      :continue_on_failure => false,      
    }                        
    unknown_options = options.keys - defaults.keys 
    raise "Unknown options #{unknown_options.inspect}" unless unknown_options.empty?
    options = defaults.merge( options )
    cmd.gsub!( /\s+/, ' ' )
    cmd.strip!
    puts "=> Running #{cmd.inspect}\n" unless options[ :quiet ]
    if options[ :confirm_first ]
      STDOUT << "Execute [Yn]? "
      response = STDIN.gets.chomp
      return unless response.blank? || response =~ /^(y|yes)$/i
    end
    if options[ :quiet ]
      cmd = "#{cmd} 2>&1"
      output = `#{cmd}`
      success = $?.success?
    else                                                   
      success = system(cmd) 
      output = nil           # output was already printed by system(...)                                      
    end
    unless success
      if options[ :continue_on_failure ]
        msg = "Continuing, ignoring error while running #{cmd.inspect}"
        msg += "\nOutput:\n#{output}" if output
        puts msg
      else                                 
        msg = "ERROR running #{cmd.inspect}"
        msg += "\nOutput:\n#{output}" if output
        raise msg 
      end
    end
  end                                             
end
