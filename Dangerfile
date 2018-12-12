
has_source_changes = !git.modified_files.grep(/Sources.*\.swift/).empty? || !git.added_files.grep(/Sources.*\.swift/).empty?
has_tests_changes = !git.modified_files.grep(/Sources\/PageboyTests.*\.swift/).empty? || !git.added_files.grep(/Sources\/PageboyTests.*\.swift/).empty?

# Make it more obvious that a PR is a work in progress and shouldn't be merged yet
warn("PR is classed as Work in Progress") if github.pr_title.include? "[WIP]"

# Warn when there is a big PR
warn("This PR might be a little too big, consider breaking it up.") if git.lines_of_code > 500

# Require PR description
warn "Please provide a summary in the PR description, it makes it easier to understand!" if github.pr_body.length < 5

# Check for source changes and prompt for test updates if non added.
if (has_source_changes && ! has_tests_changes)
    warn("Looks like you changed some source files, should there have been some tests added?")
end

swiftlint.lint_files