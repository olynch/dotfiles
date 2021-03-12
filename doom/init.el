;;; init.el -*- lexical-binding: t; -*-

;; This file controls what Doom modules are enabled and what order they load in.
;; Remember to run 'doom sync' after modifying it!

;; NOTE Press 'SPC h d h' (or 'C-h d h' for non-vim users) to access Doom's
;;      documentation. There you'll find information about all of Doom's modules
;;      and what flags they support.

;; NOTE Move your cursor over a module's name (or its flags) and press 'K' (or
;;      'C-c g k' for non-vim users) to view its documentation. This works on
;;      flags as well (those symbols that start with a plus).
;;
;;      Alternatively, press 'gd' (or 'C-c g d') on a module to browse its
;;      directory (for easy access to its source code).

(setq doom-localleader-key ",")

(doom! :input

       :completion
       company           ; the ultimate code completion backend
       ivy               ; a search engine for love and life

       :ui
       doom              ; what makes DOOM look the way it does
       doom-dashboard    ; a nifty splash screen for Emacs
       doom-quit         ; DOOM quit-message prompts when you quit Emacs
       hl-todo           ; highlight TODO/FIXME/NOTE/DEPRECATED/HACK/REVIEW
       modeline          ; snazzy, Atom-inspired modeline, plus API
       nav-flash         ; blink the current line after jumping
       ophints           ; highlight the region an operation acts on
       (popup +defaults)   ; tame sudden yet inevitable temporary windows
       ligatures
       unicode           ; extended unicode support for various languages
       vc-gutter         ; vcs diff in the fringe
       vi-tilde-fringe   ; fringe tildes to mark beyond EOB
       window-select     ; visually switch windows

       :editor
       (evil +everywhere); come to the dark side, we have cookies
       file-templates    ; auto-snippets for empty files
       fold              ; (nigh) universal code folding
       (format +onsave)  ; automated prettiness
       multiple-cursors  ; editing in many places at once
       snippets          ; my elves. They type so I don't have to
       word-wrap         ; soft wrapping with language-aware indent

       :emacs
       dired             ; making dired pretty [functional]
       electric          ; smarter, keyword-based electric-indent
       undo              ; persistent, smarter undo for your inevitable mistakes
       vc                ; version-control and Emacs, sitting in a tree

       :term
       eshell            ; the elisp shell that works everywhere
       vterm

       :app
       calendar
       twitter

       :checkers
       ;; syntax              ; tasing you for every semicolon you forget
       ;; spell             ; tasing you for misspelling mispelling

       :tools
       direnv
       docker
       editorconfig      ; let someone else argue about tabs vs spaces
       (eval +overlay)     ; run code, run (also, repls)
       lookup              ; navigate your code and its documentation
       lsp
       (magit +forge)             ; a git porcelain for Emacs
       pdf               ; pdf enhancements
       rgb               ; creating color strings

       :lang
       cc
       data              ; config/data formats
       elixir
       emacs-lisp        ; drown in parentheses
       ess               ; emacs speaks statistics
       (haskell +lsp)           ; a language that's lazier than I am
       javascript        ; all(hope(abandon(ye(who(enter(here))))))
       julia             ; a better, faster MATLAB
       (latex +latexmk +cdlatex)   ; writing papers in Emacs has never been so fun
       lean
       lua               ; one-based indices? one-based indices
       markdown          ; writing docs for people to ignore
       nix               ; I hereby declare "nix geht mehr!"
       ;; ocaml             ; an objective camel
       (org +jupyter +pandoc +roam)              ; organize your plain life in plain text
       (python +lsp)            ; beautiful is better than ugly
       racket
       (rust +lsp)              ; Fe2O3.unwrap().unwrap().unwrap().unwrap()
       sh
       yaml

       :email
       notmuch

       :config
       literate
       (default +bindings +smartparens))
