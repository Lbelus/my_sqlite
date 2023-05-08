
class MySqlite
  def self.my_sqlite(filelist = nil)
    cli = Cli.new(filelist)
    cli.start
  end
end

def my_sqlite_fn(filelist)
  MySqlite.my_sqlite(filelist)
end

require_relative 'my_sqlite/Cli'
require_relative 'my_sqlite/LinkedList'

my_sqlite_fn(ARGV)