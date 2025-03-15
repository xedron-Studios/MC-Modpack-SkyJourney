import crafttweaker.api.ingredient.IIngredient;
import crafttweaker.api.item.ItemDefinition;
import crafttweaker.api.recipe.replacement.Replacer;
import crafttweaker.api.recipe.type.Recipe;
import crafttweaker.api.tag.type.KnownTag;

print("[SkyJourney] CONFIGURATION");
print("- Deactivate Vanilla Tools to enforce TinkersConstruct.");
print("by SchinkTasia & Chocolate_Day");

/*
    Minecraft Vanilla
*/

// Remove Vanilla Tool Recipes
print("Removing Vanilla Tool Recipes...");
val toolTypes = ["pickaxe", "sword", "axe", "hoe", "shovel"];
val materials = ["wooden", "stone", "iron", "gold", "diamond", "netherite"];

for material in materials {
    for tool in toolTypes {
        // Delete Recipe if it exists
        val recipeName = "minecraft:" + material + "_" + tool;
        if (craftingTable.getRecipeByName(recipeName) != null) {
            craftingTable.removeByName(recipeName);
        }
    }
}
print("Removed Vanilla Tool Recipes.");

/*
    Patching Recipes
*/

// Patch Recipes, that initially used Vanilla Tools, so they use TinkersConstruct Tools instead
// Note: The following code produces warning/error messages and is subject to change in the future.
print("Patching Recipes...");
Replacer.create()
    .replace<IIngredient>(<recipecomponent:crafttweaker:input/ingredients>, <item:minecraft:iron_pickaxe>, <item:tconstruct:pickaxe>)
    .replace<IIngredient>(<recipecomponent:crafttweaker:input/ingredients>, <item:minecraft:diamond_pickaxe>, <item:tconstruct:pickaxe>.withTag({tic_upgrades: [{name: "tconstruct:diamond", level: 1}]}))
    .replace<IIngredient>(<recipecomponent:crafttweaker:input/ingredients>, <item:minecraft:diamond_axe>, <item:tconstruct:hand_axe>.withTag({tic_upgrades: [{name: "tconstruct:diamond", level: 1}]}))
    .replace<IIngredient>(<recipecomponent:crafttweaker:input/ingredients>, <item:minecraft:diamond_hoe>, <item:tconstruct:kama>.withTag({tic_upgrades: [{name: "tconstruct:diamond", level: 1}]}))
    .replace<IIngredient>(<recipecomponent:crafttweaker:input/ingredients>, <item:minecraft:iron_axe>, <item:tconstruct:hand_axe>)
    .replace<IIngredient>(<recipecomponent:crafttweaker:input/ingredients>, <item:minecraft:golden_pickaxe>, <item:tconstruct:pickaxe>)
    .replace<IIngredient>(<recipecomponent:crafttweaker:input/ingredients>, <item:minecraft:diamond_sword>, <item:tconstruct:sword>.withTag({tic_upgrades: [{name: "tconstruct:diamond", level: 1}]}))
    .replace<IIngredient>(<recipecomponent:crafttweaker:input/ingredients>, <item:minecraft:diamond_shovel>, <item:tconstruct:excavator>.withTag({tic_upgrades: [{name: "tconstruct:diamond", level: 1}]}))
    .replace<IIngredient>(<recipecomponent:crafttweaker:input/ingredients>, <item:minecraft:netherite_sword>, <item:tconstruct:sword>.withTag({tic_upgrades: [{name: "tconstruct:netherite", level: 1}]}))
    .replace<IIngredient>(<recipecomponent:crafttweaker:input/ingredients>, <item:minecraft:netherite_shovel>, <item:tconstruct:excavator>.withTag({tic_upgrades: [{name: "tconstruct:netherite", level: 1}]}))
    .replace<IIngredient>(<recipecomponent:crafttweaker:input/ingredients>, <item:minecraft:netherite_axe>, <item:tconstruct:hand_axe>.withTag({tic_upgrades: [{name: "tconstruct:netherite", level: 1}]}))
    .replace<IIngredient>(<recipecomponent:crafttweaker:input/ingredients>, <item:minecraft:netherite_hoe>, <item:tconstruct:kama>.withTag({tic_upgrades: [{name: "tconstruct:netherite", level: 1}]}))
    .replace<IIngredient>(<recipecomponent:crafttweaker:input/ingredients>, <item:minecraft:netherite_pickaxe>, <item:tconstruct:pickaxe>.withTag({tic_upgrades: [{name: "tconstruct:netherite", level: 1}]}))
.execute();
print("Patched Recipes.");