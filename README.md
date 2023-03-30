# Jailbreak-Esque Robbery game base

## About
My attempt at making a game similar to jailbreak in functionality. My hope is that I can provide an easy-to-use foundation for robbery style games (and hopefully make this a full game in itself).

## Strengths
I am familiar with the knit framework and have created a foundation codebase which compliments such. I have a standardized game event system that has a reliable system (with psuedo-null saftey) for retrieving data.

## Limitations
The limitations of this project essentially come down to my own skill, not as much time. A large one is vehicles / physics, as it's not something I'm completely familiar with.

## Used Modules
This project is foundationally built on top of knit for networking. I'll probably get into more knit stuff later, such as proper usage of signals and controllers, but as of now I am heavily utilzing their networking.

For the UI, this project uses [Fusion](https://elttob.uk/Fusion/0.2/) instead of [Roact](https://roblox.github.io/roact/). While I love the idea of taking React ideals and putting them into Roblox, it raises a lot of issues, annoyances, and compilications since not everything is implemented, and I feel as if it abstracts components in a way that is unintuitive for Roblox itself. While I understand the value in using such a project within Roblox-TS (which adds support for tailwindcss-like styling + many other functionalities via packages), I find it to be counterintuitive within raw lua. Fusion stays true to how Roblox formats code, and adds useful abstractions without forcing you into a messy component tree.

## Structure
The data structure is highly-opinionated and (maybe?) unique as I didn't look at other projects beforehand. All session data is located within the hot_data module, which represents all live and actively used data within RAM. This data is accessed from the server-side by using a module directly, while it is accessed from the client side by using knit to call that same module.

When the player joins it pulls from the cold_data module, which is a minimal module that represents all data stored between sessions, utilizing Roblox's datastorage by default. Of course, if you would like it wouldn't be incredibly difficult to use pocketbase or anything of sorts, if you're into that sorta thing.

## Overall game idea (ideas I came up with on a whim, they usually suck)
This is meant to be a robbery type game that starts players on the street, and they have to work to eventually get some sort of house / apartment. You are able to hack from your apartment, and some robberies could use it as a sort of "safe house" where you must go to cash in your earnings. You can go to your safe house to retrieve / customize cars. Much of the map is based around the city, and the map is intended to be quite large (with a high player cap). There will be a street-race system that allows players to invite others to a street race, which is another way to make money. 

# Objectives
Stuff I actually want to get done.

Key:

🟥 = Not started
🟨 = In progress
🟩 = Completed

## Robbery mechanics
- **[**🟨**]** Bank Roberry
- **[**🟥**]** Train
- **[**🟥**]** Plane
- **[**🟥**]** Money Laundering
## UI Library
- **[**🟨**]** Work out out UI design layout
- **[**🟨**]** Build re-usable components
- **[**🟥**]** Inventory Gui
## Mechanics
- **[**🟥**]** Train (actual movement mechanics)
- **[**🟥**]** Weapon System
## Map
- **[**🟥**]** Basic Map Overview
- **[**🟥**]** Basic Bank Robbery
- **[**🟥**]** Complete Road Network
- **[**🟥**]** Complete Train Track
## Car Mechanics
- **[**🟥**]** Basic car foundation
- **[**🟥**]** Street racing
- **[**🟥**]** Autonomous car driving
- **[**🟥**]** Car Stealing
## General Mechanics
- **[**🟩**]** Leaderboard
- **[**🟩**]** Custom Movement (partial sprint implementation)