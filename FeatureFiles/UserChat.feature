@UserChat @ChatWithManager
Feature: UserChat
	In order to communicate with the manager
	As a client app user
	I want a chat function

@p1 @positive @openChat
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

@p1 @sendMessage @positive @smoke
Scenario Outline: It is possible to send message to manager
	Given User exists
	And User is logged in as client
	And Manager exists
	And Chat feature turned on
	And Chat is open
	When I enter 'Hello!' at message field
	And I click 'Sent' button
	Then Message sent

@p1 @chatHistory @positive
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

@p3 @managerStatus @positive
Scenario Outline: User can see the manager's status
	Given User exists
	And User is logged in as client
	And Chat feature turned on
	And Manager exists
	And Manager is <status>
	And Client App is open
	When I open the chat with manager
	Then User see manager's status <status>
Examples:
	| status  |
	| online  |
	| offline |

@p2 @openChat @negative @exceptionMessage
Scenario: Chat icon is not displayed if the chat feature is disabled
	Given User exists
	And User is logged in as client
	And Chat feature turned off
	And Client App is open
	Then Chat icon is not displayed

@p3 @chatButton
Scenario: Button 'Open Chat' is displayed
	Given User exists
	And User is logged in as client
	And Client App is open
	Then Button 'Open Chat' is displayed in the lower right corner

@p1 @notifications
Scenario: User has notification when manager sent message if user is online
	Given User exists
	And User is logged in as client
	And Manager exists
	And Chat feature turned on
	And Manager send message 'Hello!' to user
	And User is online
	Then pop-up with manager's message 'Hello!' is displayed on user's screen

@p1 @notifications
Scenario: User has no notification when manager sent message if user is offline
	Given User exists
	And User is logged in as client
	And Chat feature turned on
	And Manager exists
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

@p1 @sendMessage @smoke
Scenario Outline: the manager can send a message to the user regardless of the user's status
	Given User exists 
	And User is logged in as client
	And Manager exists
	And Manager is <status>
	And Chat feature turned on
	And Chat with manager is open at client app
	When I enter 'Hello!' at message field
	And I click 'Sent' button
	Then Message sent
Examples:
	| status  |
	| offline |
	| online  |