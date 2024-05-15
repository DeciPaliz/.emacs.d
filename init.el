;; -*- lexical-binding: t -*-

(load-file (expand-file-name "core/macros.el" user-emacs-directory))

(load! core/elpaca)
(load! core/mod)
(load! list)

(core/load-mods)

(run-hooks 'core/before-load-hook)
(run-hooks 'core/during-load-hook)
(elpaca-process-queues)
(elpaca-wait)
(run-hooks 'core/after-during-load-hook)
(run-hooks 'core/after-load-hook)
