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
  (async-shell-command "update-home"))

(defun +nix/nixos-rebuild-switch ()
  (interactive)
  (async-shell-command "update-nixos"))

(map! :leader
      "h r h" '+nix/home-manager-switch
      "h r n" '+nix/nixos-rebuild-switch)

(set-popup-rules!
  '(("^\\*Async" :slot -1 :modeline f)))

(defun +doom/reload-with-commit ()
  (interactive)
  (require 'core-cli)
  (when (and IS-WINDOWS (file-exists-p doom-env-file))
    (warn "Can't regenerate envvar file from within Emacs. Run 'doom env' from the console"))
  ;; In case doom/reload is run before incrementally loaded packages are loaded,
  ;; which could cause odd load order issues.
  (mapc #'require (cdr doom-incremental-packages))
  (doom--if-compile "update-doom"
      (let ((doom-reloading-p t))
        (doom-initialize 'force)
        (with-demoted-errors "PRIVATE CONFIG ERROR: %s"
          (general-auto-unbind-keys)
          (unwind-protect
              (doom-initialize-modules 'force)
            (general-auto-unbind-keys t)))
        (run-hook-wrapped 'doom-reload-hook #'doom-try-run-hook)
        (print! (success "Config successfully reloaded!")))
    (user-error "Failed to reload your config")))

(map! :leader
      "h r r" '+doom/reload-with-commit)
