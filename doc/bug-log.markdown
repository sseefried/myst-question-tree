# Tue 11 Oct 2011 11:41 - Editing textile for question led to whole sub-tree disappearing

Date/Time: 

## How it happened

Damian edited the textile field for a response and found that when he went back to the
tree the entire subtree under that response was gone.

## Cause

Each response should have one child_question. (This is a has_one relationship in the
model). It turns out that a number of the responses have multiple questions. Editing
one question can change which one is returned by the child_question method. I don't
know the reason why one record is favoured over another; it seems arbitrary.

If you are just using one browser window then it should be impossible to add two
questions to a response. However, if you have two browser windows open then it is quite
possible.

## Fix


We need to make sure, when adding a new question that there are no pre-existing
questions. If there is then we should throw an exception, notify the user, and reload
the entire question tree.

## Further actions

We should also add a rake task to check and fix the question tree.

We should also start doing daily backups of the database as losing data like this is
unacceptable.