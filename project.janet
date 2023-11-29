(declare-project
  :name "test"
  :description "test" # some example metadata.

  # Optional urls to git repositories that contain required artifacts.
  :dependencies [])

(declare-executable
 :name "test"
 :entry "main.janet"
 :install true)
