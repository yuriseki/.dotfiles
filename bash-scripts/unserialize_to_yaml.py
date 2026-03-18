#!/usr/bin/env python3
"""Convert a PHP serialized string to YAML and print to stdout."""

import sys
import yaml


def php_unserialize(data: str):
    """Parse a PHP serialized string into a Python object."""

    def parse(s, pos):
        t = s[pos]
        pos += 1

        if t == 'N':
            # null: N;
            assert s[pos] == ';', f"Expected ';' at {pos}"
            return None, pos + 1

        if t == 'b':
            # bool: b:0; or b:1;
            assert s[pos] == ':', f"Expected ':' at {pos}"
            pos += 1
            val = s[pos] == '1'
            pos += 1
            assert s[pos] == ';', f"Expected ';' at {pos}"
            return val, pos + 1

        if t == 'i':
            # int: i:42;
            assert s[pos] == ':', f"Expected ':' at {pos}"
            pos += 1
            end = s.index(';', pos)
            return int(s[pos:end]), end + 1

        if t == 'd':
            # float: d:3.14;
            assert s[pos] == ':', f"Expected ':' at {pos}"
            pos += 1
            end = s.index(';', pos)
            return float(s[pos:end]), end + 1

        if t == 's':
            # string: s:5:"hello";
            assert s[pos] == ':', f"Expected ':' at {pos}"
            pos += 1
            end = s.index(':', pos)
            length = int(s[pos:end])
            pos = end + 2  # skip ':"'
            value = s[pos:pos + length]
            pos += length + 2  # skip closing '";'
            return value, pos

        if t == 'a':
            # array: a:2:{...}
            assert s[pos] == ':', f"Expected ':' at {pos}"
            pos += 1
            end = s.index(':', pos)
            count = int(s[pos:end])
            pos = end + 2  # skip ':{'
            result = {}
            is_list = True
            for i in range(count):
                key, pos = parse(s, pos)
                val, pos = parse(s, pos)
                result[key] = val
                if key != i:
                    is_list = False
            pos += 1  # skip '}'
            if is_list and count > 0:
                return list(result.values()), pos
            return result, pos

        if t == 'O':
            # object: O:9:"ClassName":2:{...}
            assert s[pos] == ':', f"Expected ':' at {pos}"
            pos += 1
            end = s.index(':', pos)
            class_name_len = int(s[pos:end])
            pos = end + 2  # skip ':"'
            class_name = s[pos:pos + class_name_len]
            pos += class_name_len + 2  # skip '":'
            end = s.index(':', pos)
            count = int(s[pos:end])
            pos = end + 2  # skip ':{'
            result = {'__class__': class_name}
            for _ in range(count):
                key, pos = parse(s, pos)
                val, pos = parse(s, pos)
                result[key] = val
            pos += 1  # skip '}'
            return result, pos

        raise ValueError(f"Unknown type '{t}' at position {pos - 1}")

    data = data.strip()
    obj, _ = parse(data, 0)
    return obj


def main():
    if len(sys.argv) < 2:
        print("Usage: unserialize_to_yaml.py <serialized_string>", file=sys.stderr)
        sys.exit(1)

    serialized = sys.argv[1]

    try:
        data = php_unserialize(serialized)
    except Exception as e:
        print(f"Error: failed to parse serialized string: {e}", file=sys.stderr)
        sys.exit(1)

    print(yaml.dump(data, default_flow_style=False, allow_unicode=True), end="")


if __name__ == "__main__":
    main()
