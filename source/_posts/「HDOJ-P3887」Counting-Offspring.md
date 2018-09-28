---
title: 「HDOJ-P3887」Counting Offspring
date: 2018-09-28 08:45:30
tags: ["HDOJ", "dfs序", "线段树"]
mathjax: true
---
### 翻译
---
#### 题目描述
给你一棵树，和它的树根 $P$，并且节点从 $1\rightarrow n$ 编号，现在定义 $f(i)$ 为 $i$ 的子树中，节点编号小于 $i$ 的节点的个数。
#### 输入格式
有多组数据 (不超过 10 组)，对于每组数据：
第一行两个整数 $n,p$ $(n\le 10^5)$ 表示树有 $n$ 个节点，树根是 $p$。
接下来的 $n-1$ 行，每行两个整数，代表一条树边。
输入以两个零作为结束。
#### 输出格式
对于每组测试数据，输出一行 $n$ 个整数 $f(1),f(2)......f(n)$，每两个数字之间以一个空格分格。

### 解题思路
---
显然，我们想要求 $f(i)$ 的话，只需要对其子树进行统计，而有不能够每一次都去遍历一遍，那样一定会超时。我们可以用 dfs 序先对整棵树进行处理，dfs 序可以将一个点的子树的编号放在一个区间内。然后用线段树进行求解 (如果暴力的在区间内统计的话，会 TLE，实锤)，按编号从小到大将点的影响加到线段树中，边查询边更新。这样总时间复杂度是 $\text{O}(n\log n)$，显然可过。
要注意输出格式，每一行最后一个数字后面不能加空格。

### 附上代码
---
```cpp
#include <iostream>
#include <cstring>
#include <cstdio>
using namespace std;
const int maxn = 2e5+3;
inline int read() {
	int x = 0, f = 1; char c = getchar();
	while (c < '0' || c > '9') {if(c == '-') f = -1; c = getchar();}
	while (c <= '9' && c >= '0') {x = x*10 + c-'0'; c = getchar();}
	return x * f;
}
int n, rt, head[maxn], Index, L[maxn], R[maxn], cnt;
struct edge {
	int nxt, to;
}ed[maxn];
inline void addedge(int x, int y) {
	ed[++cnt].nxt = head[x], ed[cnt].to = y, head[x] = cnt;
	ed[++cnt].nxt = head[y], ed[cnt].to = x, head[y] = cnt;
}
inline void dfs(int x, int fr) {
	L[x] = ++ Index;
	for(int i=head[x]; i; i=ed[i].nxt) {
		if(ed[i].to == fr) continue;
		dfs(ed[i].to, x);
	}
	R[x] = Index;
}
struct TREE {
	int l, r, sum;
}tree[maxn << 2];
struct Segment_Tree {
	#define Lson (k << 1) 
	#define Rson ((k << 1) + 1)
	inline void build(int k, int ll, int rr) {
		tree[k].l = ll, tree[k].r = rr;
		tree[k].sum = 0;
		if(tree[k].l == tree[k].r) return ;
		int mid = (tree[k].l + tree[k].r) >> 1;
		build(Lson, ll, mid);
		build(Rson, mid+1, rr);
	}
	inline void update(int k, int pos, int num) {
		if(tree[k].l == tree[k].r && tree[k].l == pos) {
			tree[k].sum += num;
			return ;
		}
		int mid = (tree[k].l + tree[k].r) >> 1;
		if(pos <= mid) update(Lson, pos, num);
		else update(Rson, pos, num);
		tree[k].sum = tree[Lson].sum + tree[Rson].sum;
	}
	inline int query(int k, int l, int r) {
		int res = 0;
		if(l <= tree[k].l && r >= tree[k].r)
			return tree[k].sum;
		int mid = (tree[k].l + tree[k].r) >> 1;
		if(l <= mid) res += query(Lson, l, r);
		if(r > mid) res += query(Rson, l, r);
		return res;
	}
}T;
int main() {
	while (scanf("%d%d", &n, &rt) == 2) {
		if(n == 0 && rt == 0) return 0;
		memset(head, 0, sizeof(head));
		cnt = 0, Index = 0;
		int x, y;
		for(int i=1; i<n; i++) {
			x = read(), y = read();
			addedge(x, y);
		}
		dfs(rt, 0);
		T.build(1, 1, n);
		for(int i=1; i<=n; i++) {
			printf("%d", T.query(1, L[i], R[i]));
			T.update(1, L[i], 1);
			if(i == n) printf("\n");
			else printf(" ");
		}
	}
}

```
