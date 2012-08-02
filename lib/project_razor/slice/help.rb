require 'erb'
require 'yaml'

module ProjectRazor
  module Slice
    # ProjectRazor Slice Boot
    # Used for all boot logic by node
     class Help < ProjectRazor::Slice::Base
       def initialize(args)
         @help_args = args
         @new_slice_style = true
         @hidden = false
         @slice_commands = {
           :default => "what_slice",
           :else => "what_slice"
         }
         @slice_name = "Help"
         @engine = ProjectRazor::Engine.instance
       end

       def get_help(slice,action)
         help_details = YAML.load_file(File.join(File.dirname(__FILE__), "#{slice.downcase}/#{slice}.yaml"))
         help_template = ERB.new(File.open(File.join(File.dirname(__FILE__), "#{slice.downcase}/#{slice}.erb"), 'r'), nil, "%")
         summary = help_details['command'][0][action][0]['summary']
         help_text = help_details['command'][0][action][1]['subactions'][0]['all']
         this_action = action
         
         puts help_template.result(binding)
       end

       def what_slice()
         what_slice = @help_args.shift
         what_action = @help_args.shift
         get_help(what_slice, what_action)
       end
         
     end
  end
end
