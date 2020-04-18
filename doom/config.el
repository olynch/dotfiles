(setq user-full-name "Owen Lynch"
      user-mail-address "root@owenlynch.org")

(setq doom-font (font-spec :family "monospace" :size 14))

(setq doom-theme 'doom-one)

(setq org-directory "~/org/")

(setq display-line-numbers-type t)

(map! :leader
      "SPC" 'counsel-M-x)

(defun +nix/home-manager-switch ()
  (interactive)
  (async-shell-command "home-manager switch"))

(defun +nix/nixos-rebuild-switch ()
  (interactive)
  (async-shell-command "sudo nixos-rebuild switch"))

(map! :leader
      "r h" '+nix/home-manager-switch
      "r n" '+nix/nixos-rebuild-switch)

(set-popup-rules!
  '(("^\\*Async" :slot -1 :modeline f)))
