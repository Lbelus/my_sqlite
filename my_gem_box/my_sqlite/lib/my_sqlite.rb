require_relative 'my_sqlite/cli'

class MySqliteInstance
  include QueryMethods

  def _execute_(object, hash)
    p object, hash
    hash.each do |method, argument|
    if object.respond_to?(method)
        object.send(method, argument)
      else
        p "#{method} does not belong to my_sqlite"
      end
    end
  end

  def instanciation(database_name = nil)
     result = true
     while result
       result = run_cli
       request = MySqliteRequest.new(result)
       _execute_(request, request.options)
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
