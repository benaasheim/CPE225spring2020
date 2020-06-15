/*
 * Defines functions for a linked list.
 * CSC 225, Assignment 7
 * Given code, Winter '20
 */

#include <stdio.h>
#include <stdlib.h>
#include "list.h"

/* lstcreate: Creates an empty linked list. */
List *lstcreate() {
    /* TODO: Complete this function.
     *       Given: n/a
     *       Returns: A pointer to a dynamically allocated List structure */
	List *list = NULL;
	list = (List *)malloc(sizeof(List));
	list->size = 0;
	list->head = NULL;
	return list;
}

Node *ndcreate() {
	Node *node = NULL;
	node = (Node *)malloc(sizeof(Node));
	node->next = NULL;
	node->data = NULL;
	return node;
}

/* lstdestroy: Destroys an existing linked list. */
void lstdestroy(List *lst) {
    /* TODO: Complete this function.
     *       Given: A pointer to a List structure
     *       Returns: n/a */
	Node *temp;
	Node *head;
	head = lst->head;
	while (head != NULL) {
		temp = head;
		head = head->next;
		free(temp);
	}
	free(lst);	
}

/* lstsize_helper: recursive function */
int lstsize_helper(Node *head, int size) {
	if (head != NULL) {
		size ++;
		return lstsize_helper(head->next, size);
	}
	else {
		return size;
	}
}

/* lstsize: Computes the size of a linked list. */
int lstsize(List *lst) {
    /* TODO: Complete this function.
     *       Given: A pointer to a List structure
     *       Returns: The size of that list */
	return lstsize_helper(lst->head, 0);
}


void *lstget_helper(Node *head, int idx) {
        if (idx == 0) {
                return head->data;
        }
        else {
                return lstget_helper(head->next, idx-1);
        }
}

/* lstget: Gets the element in a linked list at an index. */
void *lstget(List *lst, int idx) {
    /* TODO: Complete this function.
     *       Given: A pointer to a List structure, an index
     *       Returns: A pointer to that element, NULL if none exists */
	if (lst->size >= idx+1) {
		return lstget_helper(lst->head, idx);
	}
	else {
		return NULL;
	}
}

int lstset_helper(Node *head, int idx, void *data) {
        if (idx == 0) {
		head->data = data;
		return 0;
        }
        else {
                return lstset_helper(head->next, idx-1, data);
        }
}

/* lstset: Sets the element in a linked list at an index. */
int lstset(List *lst, int idx, void *data) {
    /* TODO: Complete this function.
     *       Given: A pointer to a List structure, an index, a pointer to data
     *       Returns: 0 on success, 1 if index not in bounds [0, size - 1] */
	if (lst->size < idx+1 || idx < 0) {
		return 1;
	}
	else {
		return lstset_helper(lst->head, idx, data);
	}
}

int lstadd_helper(Node *head, int idx, void *data) {
	if (idx == 1) {
		Node *dt = ndcreate();
		dt->data = data;
		dt->next = head->next;
		head->next = dt;
		return 0;
	}
	else {
		return lstadd_helper(head->next, idx-1, data);
	}
}

/* lstadd: Adds an element to a linked list at an index. */
int lstadd(List *lst, int idx, void *data) {
    /* TODO: Complete this function.
     *       Given: A pointer to a List structure, an index, a pointer to data
     *       Returns: 0 on success, 1 if index not in bounds [0, size] */
	if (idx < 0 || idx > lst->size) {
		return 1;
	}
	else {
		if (idx == 0) {
			Node *dt = ndcreate();
			dt->data = data;
			dt->next = lst->head;
			lst->head = dt;	
			lst->size++;
			return 0;
		}
		else {
			lst->size++;
			return lstadd_helper(lst->head, idx, data);
		}
	}
}

void *lstremove_helper(Node *head, int idx) {
        if (idx == 1) {
		Node *junk = head->next;
                Node *NXT = head->next->next;
		head->next = NXT;
		return junk->data;
        }
        else {
                return lstremove_helper(head->next, idx-1);
        }
}
/* lstremove: Removes an element from a linked list at an index. */
void *lstremove(List *lst, int idx) {
    /* TODO: Complete this function.
     *       Given: A pointer to a List structure, an index
     *       Returns: A pointer to the removed element, NULL if none exists */
	if (lst->size < idx+1 || idx < 0) {
		return NULL;
	}
	else {
		lst->size --;
		if (idx == 0) {
			Node *junk = lst->head;
			Node *NXT = lst->head->next;
			lst->head = NXT;
			return junk->data;
		}
		else {
			return lstremove_helper(lst->head, idx);
		}
	}
}




Node *lstreverse_helper(Node *head, Node *prev) {
	if (head->next == NULL) {
		head->next = prev;
		return head;
	}
	else {
		Node *temp = head->next;
		head->next = prev;
		return lstreverse_helper(temp, head);
	}
}

void other(List *list, Node *head, int idx) {
	if (head->next != NULL) {
		other(list, head->next, idx-1);
	}
	lstadd(list, idx, head->data);
}

/* lstreverse: Creates a new linked list in reverse order. */
List *lstreverse(List *lst) {
    /* TODO: Complete this function.
     *       Given: A pointer to a List structure
     *       Returns: A pointer to a newly allocated List containing the
     *                same elements in reversed order */
	List *list = lstcreate();
	if (lst->size > 0) {
		other(list, lst->head, lst->size - 1);
	}
	return list;
}
