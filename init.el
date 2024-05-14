;;; init.el --- -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:

(load-file (expand-file-name "core/macros.el" user-emacs-directory))

(load! core/elpaca)
(load! core/mod)
(load! lists/list)
(load! lists/disabled)

(core/load-mods core/module-list core/disabled-module-list)

(run-hooks 'core/before-load-hook)
(run-hooks 'core/during-load-hook)
(elpaca-process-queues)
(run-hooks 'core/after-during-load-hook)
(run-hooks 'core/after-load-hook)

;;; init.el ends here
