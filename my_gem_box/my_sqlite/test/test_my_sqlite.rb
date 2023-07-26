require 'minitest/autorun'
require 'mocha/minitest'
require_relative '../lib/my_sqlite'

class MySqliteInstanceTest < Minitest::Test

    def test_cli_select
        test_array = [
            ["select first_name\nfrom data.csv\nwhere job = Engineer",";"],
            ["select first_name, last_name","from data.csv","where job = Engineer",";"],
            ["select first_name,last_name\nfrom data.csv\nwhere job = Engineer",";"],
            ["select *\nfrom data.csv\nwhere job = Engineer",";"]
        ]
        test_array.each do |_test_|
            puts "/!\\ Testing SELECT against #{_test_}:\n\n"
            MySqliteInstance.any_instance.stubs(:__get_input__).returns(*_test_)
            sqlite_instance = MySqliteInstance.new
            result = sqlite_instance.instanciation
            puts "\n\n"
        end
        
    end

    def test_cli_update
        test_array = [
            ["update data.csv","set job = пенсионер","where job = Engineer",";"],
            ["update data.csv","set job = пенсионер","age = 20",";"],
            ["update data.csv","set job = пенсионер",";"]
        ]
        test_array.each do |_test_|
            puts "/!\\ Testing UPDATE against #{_test_}:\n\n"
            MySqliteInstance.any_instance.stubs(:__get_input__).returns(*_test_)
            sqlite_instance = MySqliteInstance.new
            result = sqlite_instance.instanciation
            puts "\n\n"
        end
    # assert_equal 'stubbed value', result
    end

    def test_cli_delete
        test_array = [
            ["delete","from data.csv","where job = Engineer",";"]
        ]
        test_array.each do |_test_|
            puts "/!\\ Testing DELETE against #{_test_}:\n\n"
            MySqliteInstance.any_instance.stubs(:__get_input__).returns(*_test_)
            sqlite_instance = MySqliteInstance.new
            result = sqlite_instance.instanciation
            puts "\n\n"
        end
    # assert_equal 'stubbed value', result
    end

    


    def test_cli_insert
        test_array = [
            ["insert into data.csv","VALUES 16, 'Spooder', 'Man', 'ceiling_crawler', 23",";"],
            ["insert into data.csv","VALUES 16, 'Spooder', 'Man', 'ceiling crawler', 23",";"]
        ]
        test_array.each do |_test_|
            puts "/!\\ Testing INSERT against #{_test_}:\n\n"
            MySqliteInstance.any_instance.stubs(:__get_input__).returns(*_test_)
            sqlite_instance = MySqliteInstance.new
            result = sqlite_instance.instanciation
            puts "\n\n"
        end
    # assert_equal 'stubbed value', result
    end

    def test_cli_error
        test_array = [
            ["select error_col","from data.csv",";"],
            ["update data.csv","first_name = Burnault",";"],
            ["update data.csv","set job = пенсионер",";"]
        ]


        test_array.each do |_test_|
            puts "/!\\ Testing ERRORS against #{_test_}:\n\n"
            MySqliteInstance.any_instance.stubs(:__get_input__).returns(*_test_)
            sqlite_instance = MySqliteInstance.new
            begin
                result = sqlite_instance.instanciation
            rescue TypeError => error
                puts "Caught error: #{error}"
            end
                puts "\n\n"
        end
        # assert_equal '', stderr # No error messages
        # assert_equal 'stubbed value', result
    end


end