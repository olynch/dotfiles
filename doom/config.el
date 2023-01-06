(setq user-full-name "Owen Lynch"
      user-mail-address "root@owenlynch.org")

(setq doom-font (font-spec :family "monospace" :size 14))

(setq doom-theme 'doom-one)

(setq org-directory "~/d/org/")

(setq display-line-numbers-type t)

(set-frame-parameter (selected-frame) 'alpha '(97 . 97))
(add-to-list 'default-frame-alist '(alpha . (97 . 97)))

(setq auth-sources '("~/.authinfo"))

(setq explicit-shell-file-name "/run/current-system/sw/bin/bash")
(setq shell-file-name "/run/current-system/sw/bin/bash")

(map! :leader
      "SPC" 'counsel-M-x
      "p /" '+ivy/project-search)

(setq doom-font (font-spec :family "FiraCode Nerd Font" :size 14)
      doom-variable-pitch-font (font-spec :family "Fira Sans")
      doom-unicode-font (font-spec :family "DejaVu Sans Mono")
      doom-big-font (font-spec :family "FiraCode Nerd Font" :size 19))

(defun +dotfiles/commit ()
  (interactive)
  (async-shell-command "commit-dotfiles"))

(map! :leader
      "d c" #'+dotfiles/commit)

(defun +nix/home-manager-switch ()
  (interactive)
  (async-shell-command "home-manager switch"))

(defun +nix/nixos-rebuild-switch ()
  (interactive)
  (async-shell-command "sudo nixos-rebuild switch"))

(map! :leader
      "h r h" #'+nix/home-manager-switch
      "h r n" #'+nix/nixos-rebuild-switch)

(set-popup-rules!
  '(("^\\*Async" :slot -1 :modeline f)))

(map! :leader
      "h r r" 'doom/reload)

(after! lsp-python-ms
  (setq lsp-python-ms-executable (executable-find "python-language-server"))
  (set-lsp-priority! 'mspyls 1))

(setq-default julia-indent-offset 2)
;; (setq lsp-julia-package-dir nil)
;; (setq lsp-julia-flags `("-J/home/o/.local/julia/languageserver.so"))
;; (setq lsp-julia-default-environment "~/.julia/environments/v1.6")
(setq eglot-jl-language-server-project "~/.julia/environments/v1.6")

(add-to-list 'auto-mode-alist '("\\.epub\\'" . nov-mode))

;; (add-hook! markdown-mode
;;   (setq markdown-enable-math 'f))

(setq reftex-bibliography-commands '("bibliography" "nobibliography" "addbibresource"))

;; This fixes annoying unmatching parentheses highlighting due to half-open intervals
(after! tex
  (remove-hook 'TeX-update-style-hook #'rainbow-deliters-mode))

(defun org-insert-clipboard-image (&optional file)
  (interactive "F")
  (shell-command (concat "wl-paste > " file))
  (insert (concat "[[" file "]]"))
  (org-display-inline-images))

(map! :after evil-org
      :map evil-org-mode-map
      :i "C-k" #'evil-insert-digraph)

(setq org-agenda-skip-function-global '(org-agenda-skip-entry-if 'todo 'done))

(org-babel-do-load-languages
 'org-babel-load-languages
 '((emacs-lisp . t)
   (julia . t)
   (python . t)
   (jupyter . t)))

(setq org-babel-default-header-args:jupyter-python '((:async . "yes")
                                                     (:session . "py")
                                                     (:kernel . "python3")
                                                     (:exports . "both")))

;; (require 'lsp)
;; (add-to-list 'lsp-language-id-configuration '(zig-mode . "zig"))
;; (lsp-register-client
;;  (make-lsp-client
;;   :new-connection (lsp-stdio-connection "zig")
;;   :major-modes '(zig-mode)
;;   :server-id 'zls))

(defun +zoom/open-link ()
  (interactive)
  (shell-command
   (format (concat "chromium '" (browse-url-url-at-point) "' > /dev/null 2>&1 &"))))

(map! :leader
      "o z" '+zoom/open-link)

;;Fixes lag when editing idris code with evil
(defun ~/evil-motion-range--wrapper (fn &rest args)
  "Like `evil-motion-range', but override field-beginning for performance.
See URL `https://github.com/ProofGeneral/PG/issues/427'."
  (cl-letf (((symbol-function 'field-beginning)
             (lambda (&rest args) 1)))
    (apply fn args)))

(setq company-global-modes '(not idris2-mode idris2-repl-mode))
(setq idris2-interpreter-flags '("--no-prelude"))

(setq mastodon-instance-url "https://mathstodon.xyz"
      mastodon-active-user "olynch")

(use-package! quarto-mode
  :mode ("\\.qmd\\'" . poly-quarto-mode))

(setq tidal-boot-script-path "~/g/dotfiles/doom/BootTidal.hs")

(map! :map tidal-mode-map
 :n "C-RET" 'tidal-run-line)

(setq ledger-binary-path "hledger")
