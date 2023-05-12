require 'csv'

class MySqliteRequest 

    attr_accessor :db, :col_id

    def initialize(db = nil, col_id = nil)
        @db = db
        @col_id = col_id
    end

    def from(table_name)
        @db = set_table(table_name)
        self
    end

    def select(column_name)
        p "the column is" 
        p col_id = @db.get_column_id('job')
        self
    end

    def where(column_name, criteria)
         @db = @db.search(criteria)
        self
    end

    def join(column_on_db_a, filename_db_b, column_on_db_b)
        db_b = set_table(filename_db_b)
        id_a = db_b.get_column_id(column_on_db_a)
        db_b.get_db(0 , id_a)
        # filename_db_b.get_db
        # @db.get_db
        self
    end

    # def order(order, column_name)

    # end

    # def insert(table_name)

    # end

    # def values(data)

    # end

    # def update(table_name)

    # end

    # def set(data)

    # end

    # def delete

    # end
    private 
    def set_table(table_name)
        db = InvertedIndex.new
        headers = CSV.open(table_name, headers: true).first.headers
        db.insert("0", headers.join(','))
        # p CSV.open(table_name)
        CSV.foreach(table_name, headers: true) do |row|
            # p row['index']
            id = row['index']
            text = row.to_s
            db.insert(id, text)
        end
        db
        # p CSV.open(table_name, headers: true).first.headers
    end
end


require_relative 'InvertedIndex'
# @db = InvertedIndex.new
# CSV.foreach('table_name', headers: true) do |row|
#     id = row['index']
#     text = row.to_s
#     @db.insert(id, text)
# end
# return @db

request = MySqliteRequest.new
request = request.from('data.csv')
# request = request.select('job')
request = request.join('job', 'data.csv', 'job')
# request = request.where('job', 'Sales Manager')