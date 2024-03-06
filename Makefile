# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: lfabbian <lfabbian@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2023/02/26 10:00:34 by dferreir          #+#    #+#              #
#    Updated: 2023/04/10 13:08:05 by dferreir         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

#COLORS
GREEN		= \033[0;32m
RED 		= \033[0;31m
BOLD		= \033[1m
NORMAL		= \033[0m
UP 			= \033[A
CUT 		= \033[K

#OUTPUT
NAME		= minishell

#FILES
LIBFT		= $(LIBFT_DIR)libft.a
LIBFT_DIR	= ./libft/
LIBFT_HEADS	= $(LIBFT_DIR)incs/

HEADS_LIST	= minishell.h
HEADS_DIR	= ./incs/
HEADS		= $(addprefix $(HEADERS_DIRECTORY), $(HEADERS_LIST))

SRCS_DIR	= ./srcs/
SRCS_FILES	= main.c parse.c signals.c utils.c echo.c env.c pwd.c exit.c builtins.c env_utils.c export.c export_utils.c unset.c cd.c cd_utils.c sort_export.c heredoc.c path_cmd.c init.c utils2.c utils3.c utils4.c utils5.c utils6.c
SRCS		:= ${addprefix ${SRCS_DIR}, ${SRCS_FILES}}

OBJS_DIR	= ./objs/
OBJS_FILES	:= ${SRCS_FILES:.c=.o}
OBJS		:= ${addprefix ${OBJS_DIR}, ${OBJS_FILES}}

LDFLAGS		= -lreadline -L /Users/dferreir/.brew/Cellar/readline/8.2.1/lib
#LDFLAGS		= -lreadline -L .brew/opt/readline/lib -I .brew/opt/readline/include

#COMMANDS
CC			= gcc
CFLAGS		= -Wall -Wextra -Werror
AR			= ar rcs
MKDIR		= mkdir -p
RM			= rm -rf
LIBS		= -lft -L$(LIBFT_DIR)
INCS		= -I$(HEADS_DIR) -I$(LIBFT_HEADS)

all: ${NAME}

#Compile normal executable
${NAME}: ${LIBFT} ${OBJS_DIR} ${OBJS}
	@${CC} -g ${CFLAGS} ${LIBS} ${INCS} ${OBJS} -o ${NAME} ${LDFLAGS}
	@echo "$(GREEN)[$(BOLD)OK$(NORMAL)$(GREEN)]$(NORMAL) created and compiled object files"
	@echo "$(GREEN)[$(BOLD)OK$(NORMAL)$(GREEN)]$(NORMAL) $(BOLD)$(NAME)$(NORMAL) is ready"

#Create objects directory
${OBJS_DIR}:
	@${MKDIR} ${OBJS_DIR}

#Compile normals objects
${OBJS_DIR}%.o: ${SRCS_DIR}%.c
	@echo "$(RED)[$(BOLD)Compiling$(NORMAL)$(RED)]$(NORMAL) $<$(UP)$(CUT)"
	@${CC} -g ${CFLAGS} ${INCS} -I/Users/dferreir/.brew/Cellar/readline/8.2.1/include -o $@ -c $<

${LIBFT}:
	@make -C ${LIBFT_DIR}

#Clean obj files
clean:
	@make -C ${LIBFT_DIR} clean
	@${RM} ${OBJS_DIR}
	@echo "$(GREEN)[$(BOLD)OK$(NORMAL)$(GREEN)]$(NORMAL) object files deleted"

#Clean objs files and name
fclean:	clean
	@${RM} ${LIBFT}
	@${RM} ${NAME}
	@echo "$(GREEN)[$(BOLD)OK$(NORMAL)$(GREEN)]$(NORMAL) $(BOLD)$(NAME)$(NORMAL) deleted"

re: fclean all

.PHONY: all clean fclean re
