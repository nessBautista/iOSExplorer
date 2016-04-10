//
//  LinkedList.h
//  SwiftAndCpp
//
//  Created by Nestor Javier Hernandez Bautista on 4/9/16.
//  Copyright © 2016 Nestor Javier Hernandez Bautista. All rights reserved.
//

#ifdef __cplusplus
extern "C"
{
#endif
    typedef struct node_str{
        int data;
        struct node_str *next;
    }Node;
    
    typedef struct list_str{
        Node *first;
        Node *last;
    }List;
    
    List *getEmptyList();
    void insertAtBack(List *l, int val);
    void printList(List *l);
    void removeAtBack(List *l);
    void printNumber();
#ifdef __cplusplus
}
#endif