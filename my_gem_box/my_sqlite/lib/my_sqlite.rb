require_relative 'my_sqlite/cli_igor'

class MySqliteInstance
  include QueryFunc

  def instanciation(database_name = nil)
     result = true
     while result
       result = run_cli
       request = MySqliteRequest.new(result)
     end
  end

end

def my_sqlite(database_name = nil)
  sqlite_object = MySqliteInstance.new
  sqlite_object.instanciation
end

require_relative 'my_sqlite/my_sqlite_request'
#require_relative 'InvertedIndex'

my_sqlite
