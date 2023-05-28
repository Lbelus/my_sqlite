#require_relative 'my_sqlite_request.rb'

class Query
    # @param {String} command
    # @param {String[]} columns
    # @param {String} table
    # @param {String[][]} where
    # @param {String[][]} join
    attr_accessor :from, :select, :where, :join, :order, :insert, :values, :update, :set, :delete    

    def initialize(from = nil, select = nil, where = nil, join = nil, order = nil, insert = nil, values = nil, update = nil, set = nil, delete = nil)
        @update = update
        @insert = insert
        @from = from
        @select = select
        @where = where
        @join = join
        @order = order 
        @values = values
        @set = set
        @delete = delete
    end
end


module QueryMethods 

    def iskeyword?(str)
        cmnds = ['SELECT', 'INSERT', 'UPDATE', 'DELETE', 'FROM', 'WHERE']
        upper = str.upcase #upper case string
        return cmnds.include?(upper) 
    end

    def isfrom?(str)
        upper = str.upcase
        return (upper == 'FROM')
    end

    ################ get text #################
    # Gets the input from the keyboard.
    # @return {String}
    def get_text()
        text = ""
        while (1) 
            text += gets.chomp
            if text[text.length() - 1] == ';'
                text = text.chop
                text.gsub!(", ", ",")
                break;
            end
            text += ' '
        end
        text
    end

    ##################### errors? ################
    # Check the correctness of the original query.
    def errors?(query)
        if (query.length() < 4)
            return true;
        elsif (!iskeyword?(query[0]))
            return true;
        #check select
        # elsif (query[0].casecmp("select") == 0)
        #     valid_select?(query)
        else 
            return false;
        end
    end

    ##################### valid_select? ################
    def valid_select?(query)

    end


    ##################### valid_from ##################
    # Checks the correctness of the FROM keyword.
    # @param {String[]} query. Original query split by words. 
    # @return {Boolean}
    def valid_from?(query)
        if  query.length() >= 4         && 
            count_from(query) == 1      &&
            query[2].casecmp("from") == 0
                return true
        else 
            false
        end
    end

    ##################### count_from ##################
    # @param {String[]} query. Original query split by words. 
    # Counts the number of FROM keywords.
    # @return {Integer}
    def count_from(query) 
        count = 0
        query.each do |w|
            if w.casecmp("from") == 0
                count += 1
            end
        end
        count
    end

    def get_where_cndt(query, query_class) 
        where_idx = find_keyword_idx(query, 'where')
        if (!where_idx.empty?()) 
            query_class.where = Array.new
            where_idx.each do |where_loc|
                where_cndt = Array.new
                #add three words after where
                where_cndt.push(query[where_loc + 1])
                # skip equal sign and add criteria
                where_cndt.push(query[where_loc + 3]) 
                query_class.where.push(where_cndt)        
            end
        end
    end
    
    def get_join_cndt(query, query_class) 
        join_idx = find_keyword_idx(query, 'join')          
        if (!join_idx.empty?())
            join_cndt = Array.new
            join_loc = join_idx[0]
            join_cndt.push(query[join_loc + 3])
            join_cndt.push(query[join_loc + 1])
            # skip equal sign
            join_cndt.push(query[join_loc + 5])
            query_class.join = join_cndt
        end
    end


    ##################### get_query ##################
    # @param {String[]} query. Original query split by words. 
    # @return {Query}. The object of the query class.  
    def get_query(query)
        #add columns to 'select' and table name to 'from'
        q = Query.new(query[3], query[1].split(','));
        get_where_cndt(query, q)
        get_join_cndt(query, q)
        q
    end

    ##################### find_where_idx ##################
    # Finds locations of all WHERE keywords in the query.
    #
    # Returns an array of indeces or empty array.
    def find_keyword_idx(query, keyword) 
        keyword_idx = Array.new    
        count = 0
        query.each do |w|
            if w.casecmp(keyword) == 0
                keyword_idx.push(count)
            end
            count += 1
        end
        keyword_idx
    end

    ##################### run_cli ##################
    def run_cli() 
        puts "Enter the input"
        query = get_text();
        query = query.split(' ');
        if !errors?(query)
            return get_query(query)
        else
            return nil
        end
    end

end

include QueryMethods
# p run_cli()  

