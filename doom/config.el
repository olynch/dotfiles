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
