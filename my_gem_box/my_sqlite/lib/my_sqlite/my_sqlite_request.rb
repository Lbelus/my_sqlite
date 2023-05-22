require 'csv'

class MySqliteGetter

  attr_reader :options, :db

  def initialize(db = nil)
    @db = db
  end

  def get_from
    @db
  end

end

module MySqliteSetter

    def set_from(db)
      @db = db
    end
    
    def object_to_hash(obj)
      hash = {}
      obj.instance_variables.each do |var|
        hash[var[1..-1]] = obj.instance_variable_get(var)
      end
      p hash
    end
end


class MySqliteRequest < MySqliteGetter
  include MySqliteSetter

    attr_accessor :options

    def initialize(query = nil)
      super
      @options = object_to_hash(query) 
    end

    def table(table_name = 'data.csv')
      db = set_table(table_name)
      p set_from(db)
      p "here"
      self
    end



=begin
    def select(column_name)
        @col_id = @db.get_column_id(column_name)
        self
    end

    def where(column_name, criteria)
         @searched_value = criteria
         db = @db.search(criteria)
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
            p @join = set_table(merge, false)
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
        if @values == false
          @values = true
        end
        @data = data
        # p @data
        self
    end

    def update(table_name)
    @db = set_table(table_name)
    if @update == false
        @update = true
    end
    self
    end

    def set(data)
      if @set == false
        @set = true
      end
      @data = data
        self
    end

    def delete
        if @delete == false
            @delete = true
        end
        self
    end

    def run
        if @insert == true
          @db.insert_hash(@data)
        end
        if @values == true 
          @db.update_value(@data)
        end
        if @set == true
          p @db
          id_list = @db.get_id_list(@searched_value)
          @db.modify_column(@data, id_list)
        end
        if @select == true 
            @db.each do |elem|
              elem.split(',')[@col_id]
            end
        else 
          p @db
        end
        p "sanity check : #{@db.inspect}"
    self
    end
=end

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
=begin
request = MySqliteRequest.new
  request.from('data.csv')
# request = request.from('data.csv').join('last_name', 'data.csv', 'age')
# request = request.from('data.csv').order(:asc,'job').run
# request = request.from('data.csv').select('first_name').where('job', 'Engineer').run
# request = request.join('last_name', 'data.csv', 'age')
insert_data = {
   'index' => 17,
   'first_name' => 'Peter',
   'last_name' => 'Parker',
   'job' => 'Photographer',
   'age' => 23
}

update_data = {
   'index' => 17,
   'first_name' => 'Spooder',
   'last_name' => 'Man',
   'job' => 'ceiling crawler'
}

set_data = {
    'job' => "пенсионер",
}

p "insert data"
#request = request.insert('data.csv').values(insert_data).run
p "update data"
#request = request.update('data.csv').values(update_data).run
#  request = request.update('data.csv').set(set_data).where('job', 'Engineer').run
=end

