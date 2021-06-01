@update
Feature: UpdateDataInDB

@positive
Scenario Outline: update data in db using conditions
	Given data base is connected
	#And table Products with parameters Id, Name, Count exist in data base
	And product with parameters Name = 'Test', Count = 400, Id = 1 exist in table
	Given update parameters Name to <new_name> and Count to <new_count> where condition <conditions_name> = <conditions>
	Then succesfully updated table with data Name = <new_name> and Count = <new_count>
Examples:
	| new_name     | new_count | conditions_name | conditions |
	| 'Apple'      | 2000      | Name            | 'Test'     |
	| 'PinApple'   | 1         | Count           | 400        |
	| 'Watermelon' | 7465869   | Id              | 1          |