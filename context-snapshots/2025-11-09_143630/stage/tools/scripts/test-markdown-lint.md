<!-- markdownlint-disable MD001 -->
<!-- markdownlint-disable MD010 -->
<!-- markdownlint-disable MD022 -->
<!-- markdownlint-disable MD031 -->
<!-- markdownlint-disable MD032 -->
<!-- markdownlint-disable MD040 -->
<!-- markdownlint-disable MD046 -->

# Test Markdown File

This file has intentional linting errors for testing.

## Heading Level Jump (MD001)

This heading jumped from h1 to h4.

## Second Heading

No blank line before this heading (MD022).

## Another Heading

No blank line after previous heading (MD022).

Here's a list:

- Item 1
- Item 2
- Item 3

No blank lines around the list (MD032).

Here's some code:

```text
No language specified (MD040)
This is a code block
```

No blank line before/after code block (MD031).

Some text here.

```javascript
console.log("This one has a language");
```

  This line has a hard tab at the start (MD010).

- Another list item
- Without proper spacing

The end.
