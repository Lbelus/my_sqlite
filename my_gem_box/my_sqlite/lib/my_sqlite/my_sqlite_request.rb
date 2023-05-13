require 'csv'

class MySqliteRequest 

    attr_accessor :db, :col_id, :join, :order, :insert, :data

    def initialize(db = nil, col_id = nil, join = false, order = false, insert = false, data = nil)
        @db = db
        @col_id = col_id
        @join = join
        @insert = insert
        @data = data
    end
# create subclass to that act a setter for class to get.  
    def from(table_name)
        @db = set_table(table_name)
        self
    end

    def select(column_name)
        @col_id = @db.get_column_id(column_name)
        self
    end

    def where(column_name, criteria)
         @db = @db.search(criteria)
        self
    end

    def join(column_on_db_a, filename_db_b, column_on_db_b)
        # if @join == false
        #     @join = true
        # else
            id_a = @db.get_column_id(column_on_db_a)
            db_a = @db.from_to(0 , id_a )
            id_a += 1

            db_b = set_table(filename_db_b)
            id_b = db_b.get_column_id(column_on_db_b)
            db_b = db_b.from_to(id_a , id_b)

            merge = db_a.zip(db_b).map(&:flatten)
            merge = convert_to_csv(merge)
            @join = set_table(merge, false)
            # @join = false
        # end
        self
    end

    def order(order, column_name)
        # if @order == false
        #     @order = true
        # else
            col_id = @db.get_column_id(column_name)
            db = @db.get_db
            headers = db[0]
            db.shift
            case order
            when :asc
                db.sort_by! { |row| row[col_id] }
            when :desc
                db.sort_by! { |row| row[col_id] }.reverse!
            end
            db.unshift(headers)
            db_csv = convert_to_csv(db)
            @db = set_table(db_csv, false)
            # @order = false
        # end
        self
    end

    def insert(table_name)
        @db = set_table(table_name)
        if @insert == false
            @insert = true
        # else
        # code is working but it's not exactly what the upskill specs requires
            # db = @db.get_db
            # insert_db = []
            # CSV.foreach(table_name, headers: true) do |row|
            #     id = row['index']
            #     text = row.to_s.split(',')
            #     insert_db << text
            # end
            # insert_db.shift
            # insert_db.each do |elem|
            #     db << elem
            # end
            # db_csv = convert_to_csv(db)
            # @db = set_table(db_csv, false)
            # @insert = false
        end

        self
    end

    def values(data)
        @data = data
        # p @data
        self
    end

    # def update(table_name)

    # end

    # def set(data)

    # end

    # def delete

    # end
    def run

        # if @insert == true
            @db.insert_hash(@data)
        # end
        # p @db
        # @db.each do |elem|
        #     p elem.split(',')[@col_id]
        # end
        self
    end


    private 
    def set_table(table_name, is_file = true)
        db = nil 
        if is_file
            db = from_file(table_name)
        else
            db = from_variable(table_name)
        end
        db
    end

    def from_file(table_name)
        db = InvertedIndex.new
        headers = CSV.open(table_name, headers: true).first.headers
        db.insert("0", headers.join(','))
        CSV.foreach(table_name, headers: true) do |row|
            id = row['index']
            text = row.to_s
            db.insert(id, text)
        end
        db
    end

    def from_variable(table_name)
        db = InvertedIndex.new
        headers = nil
        CSV.parse(table_name) do |row|
          headers = row
          break
        end
        db.insert("0", headers.join(','))
        CSV.parse(table_name, headers: true) do |row|
            id = row['index']
            text = row.to_s
            db.insert(id, text)
        end
        db
    end


    def convert_to_csv(matrix)
        csv_table = CSV.generate do |csv|
                matrix.each do |row|
                row[-1].chomp!
                csv << row
            end
        end
        csv_table
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
# request = request.from('data.csv')
# request = request.select('first_name').where('job', 'Engineer').run
# request = request.join('last_name', 'data.csv', 'age')
# request = request.order(:asc,'job')
data = {
  'index' => 17,
  'first_name' => 'Peter',
  'last_name' => 'Parker',
  'job' => 'Photographer',
  'age' => 23
}
request = request.insert('data.csv').values(data).run





