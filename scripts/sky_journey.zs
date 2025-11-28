import crafttweaker.api.ingredient.IIngredient;
import crafttweaker.api.recipe.replacement.Replacer;
import mods.jeitweaker.Jei;

print("[SkyJourney] CONFIGURATION");
print("- Deactivate Vanilla Tools to enforce TinkersConstruct.");
print("by SchinkTasia & Chocolate_Day");

/*
    Minecraft Vanilla
*/

// Remove Vanilla Tool Recipes
print("Removing Vanilla Tool Recipes...");
craftingTable.remove(<item:minecraft:wooden_pickaxe>);
craftingTable.remove(<item:minecraft:wooden_sword>);
craftingTable.remove(<item:minecraft:wooden_axe>);
craftingTable.remove(<item:minecraft:wooden_hoe>);
craftingTable.remove(<item:minecraft:wooden_shovel>);

craftingTable.remove(<item:minecraft:stone_pickaxe>);
craftingTable.remove(<item:minecraft:stone_sword>);
craftingTable.remove(<item:minecraft:stone_axe>);
craftingTable.remove(<item:minecraft:stone_hoe>);
craftingTable.remove(<item:minecraft:stone_shovel>);

craftingTable.remove(<item:minecraft:iron_pickaxe>);
craftingTable.remove(<item:minecraft:iron_sword>);
craftingTable.remove(<item:minecraft:iron_axe>);
craftingTable.remove(<item:minecraft:iron_hoe>);
craftingTable.remove(<item:minecraft:iron_shovel>);

craftingTable.remove(<item:minecraft:golden_pickaxe>);
craftingTable.remove(<item:minecraft:golden_sword>);
craftingTable.remove(<item:minecraft:golden_axe>);
craftingTable.remove(<item:minecraft:golden_hoe>);
craftingTable.remove(<item:minecraft:golden_shovel>);

craftingTable.remove(<item:minecraft:diamond_pickaxe>);
craftingTable.remove(<item:minecraft:diamond_sword>);
craftingTable.remove(<item:minecraft:diamond_axe>);
craftingTable.remove(<item:minecraft:diamond_hoe>);
craftingTable.remove(<item:minecraft:diamond_shovel>);

craftingTable.remove(<item:minecraft:netherite_pickaxe>);
craftingTable.remove(<item:minecraft:netherite_sword>);
craftingTable.remove(<item:minecraft:netherite_axe>);
craftingTable.remove(<item:minecraft:netherite_hoe>);
craftingTable.remove(<item:minecraft:netherite_shovel>);

// Hide Vanilla Tools from JEI
print("Hiding Vanilla Tools from JEI...");

// Wooden Tools
Jei.hideIngredient(<item:minecraft:wooden_pickaxe>);
Jei.hideIngredient(<item:minecraft:wooden_sword>);
Jei.hideIngredient(<item:minecraft:wooden_axe>);
Jei.hideIngredient(<item:minecraft:wooden_hoe>);
Jei.hideIngredient(<item:minecraft:wooden_shovel>);

// Stone Tools
Jei.hideIngredient(<item:minecraft:stone_pickaxe>);
Jei.hideIngredient(<item:minecraft:stone_sword>);
Jei.hideIngredient(<item:minecraft:stone_axe>);
Jei.hideIngredient(<item:minecraft:stone_hoe>);
Jei.hideIngredient(<item:minecraft:stone_shovel>);

// Iron Tools
Jei.hideIngredient(<item:minecraft:iron_pickaxe>);
Jei.hideIngredient(<item:minecraft:iron_sword>);
Jei.hideIngredient(<item:minecraft:iron_axe>);
Jei.hideIngredient(<item:minecraft:iron_hoe>);
Jei.hideIngredient(<item:minecraft:iron_shovel>);

// Golden Tools
Jei.hideIngredient(<item:minecraft:golden_pickaxe>);
Jei.hideIngredient(<item:minecraft:golden_sword>);
Jei.hideIngredient(<item:minecraft:golden_axe>);
Jei.hideIngredient(<item:minecraft:golden_hoe>);
Jei.hideIngredient(<item:minecraft:golden_shovel>);

// Diamond Tools
Jei.hideIngredient(<item:minecraft:diamond_pickaxe>);
Jei.hideIngredient(<item:minecraft:diamond_sword>);
Jei.hideIngredient(<item:minecraft:diamond_axe>);
Jei.hideIngredient(<item:minecraft:diamond_hoe>);
Jei.hideIngredient(<item:minecraft:diamond_shovel>);

// Netherite Tools
Jei.hideIngredient(<item:minecraft:netherite_pickaxe>);
Jei.hideIngredient(<item:minecraft:netherite_sword>);
Jei.hideIngredient(<item:minecraft:netherite_axe>);
Jei.hideIngredient(<item:minecraft:netherite_hoe>);
Jei.hideIngredient(<item:minecraft:netherite_shovel>);

print("Hidden Vanilla Tools from JEI.");

print("Removed Vanilla Tool Recipes.");

/*
    Patching Recipes
*/

// Patch Recipes, that initially used Vanilla Tools, so they use TinkersConstruct Tools instead
// Note: The following code produces warning/error messages and is subject to change in the future.
print("Patching Recipes...");
Replacer.create()
    // Wooden Tools
    .replace<IIngredient>(<recipecomponent:crafttweaker:input/ingredients>, <item:minecraft:wooden_pickaxe>, <item:tconstruct:pickaxe>)
    .replace<IIngredient>(<recipecomponent:crafttweaker:input/ingredients>, <item:minecraft:wooden_sword>, <item:tconstruct:sword>)
    .replace<IIngredient>(<recipecomponent:crafttweaker:input/ingredients>, <item:minecraft:wooden_axe>, <item:tconstruct:hand_axe>)
    .replace<IIngredient>(<recipecomponent:crafttweaker:input/ingredients>, <item:minecraft:wooden_hoe>, <item:tconstruct:kama>)
    .replace<IIngredient>(<recipecomponent:crafttweaker:input/ingredients>, <item:minecraft:wooden_shovel>, <item:tconstruct:excavator>)
    // Stone Tools
    .replace<IIngredient>(<recipecomponent:crafttweaker:input/ingredients>, <item:minecraft:stone_pickaxe>, <item:tconstruct:pickaxe>)
    .replace<IIngredient>(<recipecomponent:crafttweaker:input/ingredients>, <item:minecraft:stone_sword>, <item:tconstruct:sword>)
    .replace<IIngredient>(<recipecomponent:crafttweaker:input/ingredients>, <item:minecraft:stone_axe>, <item:tconstruct:hand_axe>)
    .replace<IIngredient>(<recipecomponent:crafttweaker:input/ingredients>, <item:minecraft:stone_hoe>, <item:tconstruct:kama>)
    .replace<IIngredient>(<recipecomponent:crafttweaker:input/ingredients>, <item:minecraft:stone_shovel>, <item:tconstruct:excavator>)
    // Iron Tools
    .replace<IIngredient>(<recipecomponent:crafttweaker:input/ingredients>, <item:minecraft:iron_pickaxe>, <item:tconstruct:pickaxe>)
    .replace<IIngredient>(<recipecomponent:crafttweaker:input/ingredients>, <item:minecraft:iron_sword>, <item:tconstruct:sword>)
    .replace<IIngredient>(<recipecomponent:crafttweaker:input/ingredients>, <item:minecraft:iron_axe>, <item:tconstruct:hand_axe>)
    .replace<IIngredient>(<recipecomponent:crafttweaker:input/ingredients>, <item:minecraft:iron_hoe>, <item:tconstruct:kama>)
    .replace<IIngredient>(<recipecomponent:crafttweaker:input/ingredients>, <item:minecraft:iron_shovel>, <item:tconstruct:excavator>)
    // Golden Tools
    .replace<IIngredient>(<recipecomponent:crafttweaker:input/ingredients>, <item:minecraft:golden_pickaxe>, <item:tconstruct:pickaxe>)
    .replace<IIngredient>(<recipecomponent:crafttweaker:input/ingredients>, <item:minecraft:golden_sword>, <item:tconstruct:sword>)
    .replace<IIngredient>(<recipecomponent:crafttweaker:input/ingredients>, <item:minecraft:golden_axe>, <item:tconstruct:hand_axe>)
    .replace<IIngredient>(<recipecomponent:crafttweaker:input/ingredients>, <item:minecraft:golden_hoe>, <item:tconstruct:kama>)
    .replace<IIngredient>(<recipecomponent:crafttweaker:input/ingredients>, <item:minecraft:golden_shovel>, <item:tconstruct:excavator>)
    // Diamond Tools
    .replace<IIngredient>(<recipecomponent:crafttweaker:input/ingredients>, <item:minecraft:diamond_pickaxe>, <item:tconstruct:pickaxe>.withTag({tic_upgrades: [{name: "tconstruct:diamond", level: 1}]}))
    .replace<IIngredient>(<recipecomponent:crafttweaker:input/ingredients>, <item:minecraft:diamond_sword>, <item:tconstruct:sword>.withTag({tic_upgrades: [{name: "tconstruct:diamond", level: 1}]}))
    .replace<IIngredient>(<recipecomponent:crafttweaker:input/ingredients>, <item:minecraft:diamond_axe>, <item:tconstruct:hand_axe>.withTag({tic_upgrades: [{name: "tconstruct:diamond", level: 1}]}))
    .replace<IIngredient>(<recipecomponent:crafttweaker:input/ingredients>, <item:minecraft:diamond_hoe>, <item:tconstruct:kama>.withTag({tic_upgrades: [{name: "tconstruct:diamond", level: 1}]}))
    .replace<IIngredient>(<recipecomponent:crafttweaker:input/ingredients>, <item:minecraft:diamond_shovel>, <item:tconstruct:excavator>.withTag({tic_upgrades: [{name: "tconstruct:diamond", level: 1}]}))
    // Netherite Tools
    .replace<IIngredient>(<recipecomponent:crafttweaker:input/ingredients>, <item:minecraft:netherite_pickaxe>, <item:tconstruct:pickaxe>.withTag({tic_upgrades: [{name: "tconstruct:netherite", level: 1}]}))
    .replace<IIngredient>(<recipecomponent:crafttweaker:input/ingredients>, <item:minecraft:netherite_sword>, <item:tconstruct:sword>.withTag({tic_upgrades: [{name: "tconstruct:netherite", level: 1}]}))
    .replace<IIngredient>(<recipecomponent:crafttweaker:input/ingredients>, <item:minecraft:netherite_axe>, <item:tconstruct:hand_axe>.withTag({tic_upgrades: [{name: "tconstruct:netherite", level: 1}]}))
    .replace<IIngredient>(<recipecomponent:crafttweaker:input/ingredients>, <item:minecraft:netherite_hoe>, <item:tconstruct:kama>.withTag({tic_upgrades: [{name: "tconstruct:netherite", level: 1}]}))
    .replace<IIngredient>(<recipecomponent:crafttweaker:input/ingredients>, <item:minecraft:netherite_shovel>, <item:tconstruct:excavator>.withTag({tic_upgrades: [{name: "tconstruct:netherite", level: 1}]}))
.execute();
print("Patched Recipes.");
