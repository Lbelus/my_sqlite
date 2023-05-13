class InvertedIndex
    def initialize
        @data = {}
        @index = {}
    end

    def insert(id, txt)
        @data[id] = txt
        update_index(id, txt)
    end

    def insert_hash(data)
        id = new_id
        txt = data.values.join(',')
        @data[id] = txt
        update_index(id, txt)
    end

    def update_index(id, txt)
        values = txt.split(',')
        values.each do |value|
            @index[value] ||= []
            @index[value] << id
        end
    end

    def new_id
        id = (@data.keys.map(&:to_i).max + 1).to_s
    end

    def get_column_id(value)
        column_lists = @data['0'].split(',')
        col_id = column_lists.index(value)
    end

    def get_db
        matrix = []
        index = 0
        @data.each do |elem|
            row = []
            row = elem[1].split(',')
            matrix << row
        end
       matrix
    end

    def search(value)
        id_list = @index[value]
        return [] unless id_list
        id_list.map { |id| @data[id] }
    end

    def from_to(from, to)
        matrix = []
        index = 0
        @data.each do |elem|
            row = []
            values = elem[1].split(',')
            for val in from..to do
                row[index] = values[val]
                index += 1
            end
            index = 0
            matrix << row
        end
        matrix
    end

end