#require_relative 'my_sqlite_request.rb'

class Query
    # @param {String} command
    # @param {String[]} columns
    # @param {String} table
    # @param {String[][]} where
    # @param {String[][]} join
    attr_accessor :command, :columns, :from, :where, :join    
    
    def initialize(command = nil, columns = nil, from = nil, where = nil, join = nil)
        @command = command
        @columns = columns
        @from = from
        @where = where
        @join = join
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



##################### get_query ##################
# @param {String[]} query. Original query split by words. 
# @return {Query}. The object of the query class.  
def get_query(query)
    q = Query.new(query[0].upcase, query[1].split(','), query[3]);
    where_idx = find_where_idx(query)
    where_cndt = Array.new
    if (!where_idx.empty?()) 
        #add three words after where
        where_loc = where_idx[0]
        where_cndt.push(query[where_loc + 1])
        where_cndt.push(query[where_loc + 2])
        where_cndt.push(query[where_loc + 3])
        q.where_cond = where_cndt
    end
    q
end

##################### find_where_idx ##################
# Finds locations of all WHERE keywords in the query.
#
# Returns an array of indeces or empty array.
def find_where_idx(query) 
    where_idx = Array.new    
    count = 0
    query.each do |w|
        if w.casecmp("where") == 0
            where_idx.push(count)
        end
        count += 1
    end
    where_idx
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

#p run_cli()
