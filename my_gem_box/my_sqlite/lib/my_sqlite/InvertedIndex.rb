class InvertedIndex
    def initialize
        @data = {}
        @index = {}
    end

    def insert(id, txt)
        @data[id] = txt
        update_index(id, txt)
    end

    def search(value)
        id_list = @index[value]
        return [] unless id_list
        id_list.map { |id| @data[id] }
    end


    def get_db(from, to)
        matrix = []

        @data.each.with_index do |elem, index|
            row = []
            values = elem[1].split(',')
            for val in from..to do
                row[val] = values[val]
            end
            matrix << row
        end
        p matrix
    end

    def get_column_id(value)
        column_lists = @data['0'].split(',')
        col_id = column_lists.index(value)
    end

    def update_index(id, txt)
        values = txt.split(',')
        values.each do |value|
            @index[value] ||= []
            @index[value] << id
        end
    end
end