Feature: ManagerChat
	In order to communicate with client
	As a manager
	I want a chat function

@p3 @clientsPage
Scenario: The manager has a page for selecting clients to communicate with them
	Given Manager exists
	And Client with name 'Lilit' exists
	And Manager App is open
	And Manager has list with clients
	Then page with client 'Lilit' is displayed

@p1 @clientsPage @smoke 
Scenario: Chat with client opens if manager clicks on the line with client and chat feature turned on
	Given Manager exists
	And Client with name 'Lilit' exists
	And Manager App is open
	And Chat feature turned on
	And Page with list of clients is displayed
	When I click on line with name 'Lilit'
	Then Chat with client 'Lilit' is open

@p2 @clientsPage @negative
Scenario: The manager has a page for selecting clients to communicate with them if chat feature turned off
	Given Manager exists
	And Manager App is open
	And Chat feature turned off
	Then Page with list of clients is not displayed

@p1 @notifications
Scenario: Manager has notification when user sent message if manager is online
	Given User exists
	And User is logged in as client
	And Manager exists
	And Chat feature turned on
	And User send message 'Hello!' to manager
	And Manager is online
	Then pop-up with user's message 'Hello!' is displayed on manager's screen

@p1 @notifications
Scenario: Manager has no notification when user sent message if manager is offline
	Given User exists
	And User is logged in as client
	And Manager exists
	And Chat feature turned on
	And User send message 'Hello!' to manager
	And Manager is offline
	Then pop-up with user's message 'Hello!' is not displayed on manager's screen

@p1 @notifications
Scenario: Redirecting to a page with a chat with a client if the manager clicks on the client's phone on notification
	Given User exists with name 'Lilit' and phone number '12345'
	And User is logged in as client
	And Manager exists
	And Chat feature turned on
	And User send message 'Hello!' to manager
	And Manager is online
	And pop-up with user's message 'Hello!' and client's phone '12345' is displayed on manager's screen
	When I click on the client's phone '12345'
	Then Page with chat with Lilit is open

@p1 @notifications
Scenario: The client's phone number is displayed on the notification for the manager
	Given User exists with phone number '12345'
	And User is logged in as client
	And Manager exists
	And Chat feature turned on
	And User send message 'Hello!' to manager
	And Manager is online
	Then pop-up with user's message 'Hello!' and client's phone '12345' is displayed on manager's screen

@p3 @clientStatus @positive
Scenario Outline: Manager can see the client's status
	Given User exists
	And User is logged in as client
	And Chat feature turned on
	And Manager exists
	And Client is <status>
	And Manager App is open
	When I open the chat with client
	Then User see client's status <status>
Examples:
	| status  |
	| online  |
	| offline |

@p1 @chatHistory @positive
Scenario: Chat history is saved if manager close the application
	Given User exists with name 'Lilit'
	And User is logged in as client
	And Chat feature turned on
	And Manager exists
	And User send message 'Hello!' to manager
	And Manager has closed the application
	When I open the app
	And I open chat with 'Lilit'
	Then Previous message 'Hello!' is displayed at the chat

@p2 @openChat @negative @exceptionMessage
Scenario: Chat icon is not displayed if the chat feature is disabled
	Given Manager exists
	And Chat feature turned off
	And Manager app is open
	Then Chat icon is not displayed

@p2 @sendMessage @negative
Scenario: The message is not sent if the "message" field is empty
	Given Manager
	And Manager app is open
	And Chat feature turned on
	When I click 'Open chat' button
	And I click 'Sent' button
	Then Message is not sent

@p1 @sendMessage @positive @smoke
Scenario: It is possible to sent message to client
	Given User exists with name 'Lilit'
	And User is logged in as client
	And Manager exists
	And Chat feature turned on
	And Chat with user 'Lilit' is open at manager app
	When I enter 'Hello!' at message field
	And I click 'Sent' button
	Then Message sent


@p1 @sendMessage @smoke
Scenario Outline: the manager can send a message to the user regardless of the user's status
	Given User exists with name 'Lilit'
	And User is logged in as client
	And User is <status>
	And Manager exists
	And Chat feature turned on
	And Chat with user 'Lilit' is open at manager app
	When I enter 'Hello!' at message field
	And I click 'Sent' button
	Then Message sent
Examples:
	| status  |
	| offline |
	| online  |