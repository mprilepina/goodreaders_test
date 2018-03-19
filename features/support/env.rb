$rest_url = 'https://www.goodreads.com/author/list.xml'
$dev_key = #put valid developers key here

Before do
  def db_configuration
      db_configuration_file = File.join(File.dirname(__FILE__), '../../', 'db', 'config.yml')
       YAML.load(File.read(db_configuration_file))
  end
  ActiveRecord::Base.establish_connection(db_configuration["development"])
end

After do 
  Books.delete_all
end
