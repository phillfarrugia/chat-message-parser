# chat-message-parser
A simple solution for parsing mentions, emoticons and links from chat messages

### How to use
Parse several data type such as Mentions, Emoticons and Links from a String by initializing
a ChatMessage object with a string. Call the parse() method and pass in an Array of MessageDataTypes
to be parsed out of the string.

Example:
<br>`ChatMessage("@bob @john (success) such a cool feature; https://twitter.com/jdorfman/status/430511497475670016").parse([.Mentions, .Links, .Emoticons])`

### Verify Output

1. Find an example usage of chat-message-parser inside `AppDelegate.swift`. This will parse mentions, emoticons and links
from a message provided and print the result to the console.

2. Run the project, I have provided a very simple `SampleViewController.swift` class that allows the user to type
a message into a UITextField, press Enter on the keyboard and see the output in a UITextView.

Note: Output JSON String provided via email specified URLs be unencoded in JSON String i.e. `{ "url": "https://twitter.com/jdorfman/status/430511497475670016", "title": "Twitter / jdorfman: nice @littlebigdetail from ..." }`
In order to be a valid encoded JSON String, URLs should be escaped such as `https:\/\/twitter.com\/jdorfman\/status\/430511497475670016`.

### Unit Tests

Each core Class, Struct or File has a level of suitable unit tests in the `Chat Message ParserTests` target.
The third party libraries Quick and Nimble have been included in order to provide clearer and more exhaustive
test functionality using the BDD approach to tests.

See `ChatMessageSpec.swift` for example.

### Screenshot
<img src="http://imgur.com/VB1rQQ2.jpg" />
