@UserChat @ChatWithManager
Feature: UserChat
	In order to communicate with the manager
	As a client app user
	I want a chat function

@p2 @positive @openChat
Scenario: It is possible to open chat as authorized client
	Given User exists
	And User is logged in as client
	And Chat feature turned on
	And Client App is open
	When I click "Open chat" button
	Then Chat is open

@p2 @negative @openChat
Scenario: It is impossible to open chat as non-authorized client
	Given User exists
	And Chat feature turned on
	And Client App is open
	Then "Open chat" button is not displayed

@p4 @sendMessage @positive @smoke
Scenario Outline: It is possible to send message to manager
	Given User exists
	And User is logged in as client
	And Manager exists
	And Chat feature turned on
	And Chat is open
	When I enter '<text>' at message field
	And I click 'Sent' button
	Then Message sent
Examples:
	| text                        |
	| Hello!                      |
	| 1234567890                  |
	| Hello1234                   |
	| !@#$%^&*()_+                |
	| Hello!@#$%^&*()_+1234567890 |

@p2 @chatHistory @positive
Scenario: Chat history is saved if user close the application
	Given User exists
	And User is logged in as client
	And Chat feature turned on
	And Manager exists
	And Manager send message 'Hello!' to user
	And User has closed the application
	When I open the app
	And I click 'Open chat' button
	Then Previous message 'Hello!' is displayed at the chat

@p2 @managerStatus @positive
Scenario Outline: User can see the manager's status
	Given User exists
	And User is logged in as client
	And Chat feature turned on
	And Manager is <status>
	And Client App is open
	When I open the chat with manager
	Then User see manager's status <status>
Examples:
	| status  |
	| online  |
	| offline |

@p3 @openChat @negative @exceptionMessage
Scenario: Exception message is displayed if the chat feature is disabled
	Given User exists
	And User is logged in as client
	And Chat feature turned off
	And Client App is open
	When I click 'Open chat' button
	Then Exception message 'page not found' is displayed

@p2 @chatButton
Scenario: Button 'Open Chat' is displayed
	Given User exists
	And User is logged in as client
	And Client App is open
	Then Button 'Open Chat' is displayed in the lower right corner

@p2 @notifications
Scenario: User has notification when manager sent message if user is online
	Given User exists
	And User is logged in as client
	And Manager send message 'Hello!' to user
	And User is online
	Then pop-up with manager's message 'Hello!' is displayed on user's screen

@p2 @notifications
Scenario: User has no notification when manager sent message if user is offline
	Given User exists
	And User is logged in as client
	And Chat feature turned on
	And Manager send message 'Hello!' to user
	And User is offline
	Then pop-up with manager's message is not displayed on user's screen

@p2 @sendMessage @negative
Scenario: The message is not sent if the "message" field is empty
	Given User exists
	And User is logged in as client
	And Chat feature turned on
	And Client App is open
	When I click 'Open chat' button
	And I click 'Sent' button
	Then Message is not sent