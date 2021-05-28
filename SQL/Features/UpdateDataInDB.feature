@Update
Feature: UpdateDataInDB

@positive
Scenario Outline: update data in db using conditions
	Given data base is connected
	And table Products with parameters Id, Name, Count exist in data base
	Given update parameters Name to <new_name> and Count to <new_count> where condition <conditions_name> = <conditions>
	Then succesfully updated table with data Name = <new name> and Count = <new count>
Examples:
	| new_name | new_count | conditions_name | conditions |
	| Apple    | 2000      | name            | Test23     |
	| PinApple | 2000      | name            | Test23     |
	| Apple    | 2000      | name            | Test23     |