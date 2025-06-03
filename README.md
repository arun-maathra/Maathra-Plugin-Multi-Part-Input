# Maathra-Plugin-Multi-Part-Input

Example 1: Fixed Length Parts
In this example, we want 4 parts, each accepting 2 characters.

No of Parts : 4
Part Length(s) : 2
Variable Character/Part Length? : No
This will render 4 input fields, each with a maximum length of 2 characters.

Example 2: Variable Length Parts
Here, we want 3 parts with different lengths: the first part should accept 3 characters, the second 3 characters, and the third 4 characters (like a phone number).

No of Parts : (This will be determined by the lengths provided)
Part Length(s) : 3,3,4
Variable Character/Part Length? : Yes
This will render 3 input fields with maximum lengths of 3, 3, and 4 characters respectively.

Example 3: Another Fixed Length Example
Let's create 6 parts, each allowing 1 character (e.g., for a short code).

No of Parts : 6
Part Length(s) : 1
Variable Character/Part Length? : No
This will render 6 input fields, each with a maximum length of 1 character.

Example 4: Variable Length for a Serial Number
Suppose you need a serial number with two parts, the first being 5 characters and the second being 7.

No of Parts : (Determined by lengths)
Part Length(s) : 5,7
Variable Character/Part Length? : Yes
This will render two input fields, the first allowing 5 characters and the second allowing 7.

Additional Information
Type: Number
