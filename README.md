# term

<!--
    This is a comment block that won't show up in rendered markdown.
    The header above should have the term you are defining, where term is the 
    concept or term that this documentation is about.
-->

<!--
    How to work on this file?
    1. You can update and request review for this file when you are authenticated
       from the AskCI server term page
    2. You can also update the file as you would with git, if the repository
       is connected a merge to master will update the server.
    3. See https://vsoch.github.io/askci/docs/respository-spec for more details
-->


## Definition

Term refers to...

<!--
    The sections are up to you! All levels will be parsed into the page.
    For example, you might have Definition, History, Usage, or longer
    section names to ask a question or state an idea.
-->

## History

How would we direct a user to a question about the term history?
Here is an example of a question embedded into the text, not that it
starts with "question" to indicate being a question, and that all letters
are lowercase and separated with "-" and no spaces. The GitHub
checks provided will ensure this is maintained with each push to master.
When the server imports the updated content, it will discover this question
and index it.

<span id="question-where-does-term-originate"></span>"Term" was first used
when someone wrote it in this GitHub repository. That someone might have
been a dinosaur.

## Examples

It's helpful to provide examples for the user, and we can do this in several ways:

 - code blocks labeled with spans
 - files in an included `examples` folder in the repository referenced with a relative link
 - external urls included in links with an id that starts with "example-"

Currently, we just support the first - using a single embedded code block, and 
I'll be added the other two use cases as more testing and feedback is given.

### Code blocks

Here is a code block that is labeled as an example. The AskCI server will index the
location in the text, and also extract the example in the next code block. You
are limited to one code block for this case.

<span id="example-how-to-embed-example-in-code-block"></span>
```bash
echo "This is an example"
```


## References

<!--
    Here is what a reference might look like.
-->

 - [AskCI Site](https://ask.ci)
