@CreateUpdateDelete
Feature: Create, Update, Delete data in db

@positive @updaeData
Scenario Outline: Update existing data in DB using conditions
	Given data base is connected
	And table Products with parameters Id, Name, Count exist in data base
	And product with parameters Name = 'Test', Count = 400, Id = 1 exist in table
	When update parameters Name to <new_name> and Count to <new_count> where condition <conditions_name> = <conditions>
	Then succesfully updated table with data Name = <new_name> and Count = <new_count>
Examples:
	| new_name     | new_count | conditions_name | conditions |
	| 'Apple'      | 2000      | Name            | 'Test'     |
	| 'PinApple'   | 1         | Count           | 400        |
	| 'Watermelon' | 7465869   | Id              | 1          |

@positive @addData
Scenario Outline: Add new data in DB
	Given data base is connected
	And table Products with parameters Id, Name, Count exist in data base
	When add new product with Name <name>, Count <count> and Id <id>
	Then succesfully added new product with Name <name>, Count <count> and Id <id>
Examples:
	| name         | count      | id         |
	| 'Apple'      | 123        | 0          |
	| 'PinApple'   | 1          | 1234567890 |
	| 'Watermelon' | 1234567890 | 1          |

@positive @addData
Scenario: Delete existing data in db
	Given data base is connected
	And product with parameters Name = 'Test', Count = 400, Id = 1 exist in table
	And table Products with parameters Id, Name, Count exist in data base
	When delete product with conditions Name = 'Test', Count = 400, Id = 1
	Then succesfully deleted product with parameters Name = 'Test', Count = 400, Id = 1 from table

@positive @addData
Scenario Outline: Delete data with invalid parameters type
	Given data base is connected
	And product with parameters Name = 'Test', Count = 400, Id = 1 exist in table
	And table Products with parameters Id, Name, Count exist in data base
	When delete product with conditions Name = 'T', Count = !@#, Id = 99
	Then exception message Incorrect syntax near '!'. is displayed