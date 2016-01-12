module PixelproSdk
  module AddPage
    def self.add_controller_page name
      # source_root File.expand_path("./templates", __FILE__)
      copy_file "./templates/template_controller.rb", "app/controller/#{name}_controller.rb"
    end

    def self.event

    end
  end
end
