(setq user-full-name "Owen Lynch"
      user-mail-address "root@owenlynch.org")

(setq doom-font (font-spec :family "monospace" :size 14))

(setq doom-theme 'doom-one)

(setq org-directory "~/d/org/")

(setq display-line-numbers-type t)

(set-frame-parameter (selected-frame) 'alpha '(85 . 85))
(add-to-list 'default-frame-alist '(alpha . (85 . 85)))

(setq auth-sources '("~/.authinfo"))

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

(add-to-list 'auto-mode-alist '("\\.epub\\'" . nov-mode))

;; (add-hook! markdown-mode
;;   (setq markdown-enable-math 'f))

(add-hook! LaTeX-mode
  (setq TeX-engine 'luatex))

(setq reftex-bibliography-commands '("bibliography" "nobibliography" "addbibresource"))

(defun org-insert-clipboard-image (&optional file)
  (interactive "F")
  (shell-command (concat "wl-paste > " file))
  (insert (concat "[[" file "]]"))
  (org-display-inline-images))

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
